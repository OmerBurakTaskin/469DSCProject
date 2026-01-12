import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'core/services/api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Synaps',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AudioProcessorPage(),
    );
  }
}

class AudioProcessorPage extends StatefulWidget {
  const AudioProcessorPage({super.key});

  @override
  State<AudioProcessorPage> createState() => _AudioProcessorPageState();
}

class _AudioProcessorPageState extends State<AudioProcessorPage> {
  File? _selectedFile;
  Map<String, dynamic>? _responseData;
  bool _isLoading = false;
  bool _isPicking = false;
  String? _errorMessage;

  Future<void> _selectAudioFile() async {
    if (_isPicking) return;

    setState(() {
      _isPicking = true; 
      _errorMessage = null; 
    });

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false,
      );

      if (result != null && result.files.single.path != null) {
        setState(() {
          _selectedFile = File(result.files.single.path!);
          _responseData = null;
        });
      }
    } catch (e) {
     
      setState(() {
        _errorMessage = 'Error selecting file: $e';
      });
    } finally {
      setState(() {
        _isPicking = false;
      });
    }
  }

  /// Send audio file to backend
  Future<void> _sendToBackend() async {
    if (_selectedFile == null) {
      setState(() {
        _errorMessage = 'Please select an audio file first';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _responseData = null;
    });

    try {
      final response = await ApiService.processAudio(_selectedFile!);
      setState(() {
        _responseData = response;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  String _formatJson(Map<String, dynamic> json) {
    const encoder = JsonEncoder.withIndent('  ');
    return encoder.convert(json);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Audio Processor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: (_isLoading || _isPicking) ? null : _selectAudioFile,
              icon: _isPicking 
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)) 
                  : const Icon(Icons.audio_file),
              label: Text(_isPicking ? 'Opening...' : 'Select Audio File'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            const SizedBox(height: 16),

            // Selected file name
            if (_selectedFile != null)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle, color: Colors.green),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _selectedFile!.path.split('/').last,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 16),

            // Send button
            ElevatedButton.icon(
              onPressed: (_isLoading || _selectedFile == null)
                  ? null
                  : _sendToBackend,
              icon: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.send),
              label: Text(_isLoading ? 'Processing...' : 'Send to Backend'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 24),

            // Error message
            if (_errorMessage != null)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red[100],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.error, color: Colors.red),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),

            // Response data
            
            if (_responseData != null)
              Expanded( 
                child: SingleChildScrollView( 
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        'Result:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      const SizedBox(height: 10),

                    
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Icon(Icons.description, color: Colors.deepPurple),
                                  SizedBox(width: 8),
                                  Text(
                                    "Response",
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                ],
                              ),
                              const Divider(height: 20),
                              SelectableText(
                                _responseData!['transcript'] ?? "Metin yok.",
                                style: const TextStyle(fontSize: 16, height: 1.5),
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 16),

                      
                      Card(
                        color: Colors.purple.shade50,
                        elevation: 2,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               const Row(
                                children: [
                                  Icon(Icons.summarize, color: Colors.deepPurple),
                                  SizedBox(width: 8),
                                  Text(
                                    "Summary (AI)",
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                ],
                              ),
                              const Divider(height: 20),
                              Text(
                                _responseData!['summary_text'] ?? "Özet yok.",
                                style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20), 
                    ],
                  ),
                ),
              ),
            ],
          
        ),
      ),
    );
  }
}
