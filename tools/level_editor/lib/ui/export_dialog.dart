import 'package:flutter/material.dart';

import '../editor/level_exporter.dart';

/// Dialog showing export results (success/failure, errors, warnings).
class ExportDialog extends StatelessWidget {
  final ExportResult result;

  const ExportDialog({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF1E1E2E),
      title: Row(
        children: [
          Icon(
            result.success ? Icons.check_circle : Icons.error,
            color: result.success
                ? const Color(0xFFA6E3A1)
                : const Color(0xFFF38BA8),
            size: 24,
          ),
          const SizedBox(width: 8),
          Text(
            result.success ? 'Export Successful' : 'Export Failed',
            style: const TextStyle(color: Color(0xFFCDD6F4), fontSize: 16),
          ),
        ],
      ),
      content: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (result.success && result.outputDir != null) ...[
              Text(
                'Files written to:',
                style: const TextStyle(
                    color: Color(0xFF6C7086), fontSize: 12),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF313244),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  result.outputDir!,
                  style: const TextStyle(
                    color: Color(0xFFCDD6F4),
                    fontSize: 12,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ],
            if (result.errors.isNotEmpty) ...[
              const SizedBox(height: 12),
              const Text(
                'Errors:',
                style: TextStyle(
                  color: Color(0xFFF38BA8),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              ...result.errors.map((e) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('• ',
                            style: TextStyle(color: Color(0xFFF38BA8))),
                        Expanded(
                          child: Text(e,
                              style: const TextStyle(
                                  color: Color(0xFFCDD6F4), fontSize: 12)),
                        ),
                      ],
                    ),
                  )),
            ],
            if (result.warnings.isNotEmpty) ...[
              const SizedBox(height: 12),
              const Text(
                'Warnings:',
                style: TextStyle(
                  color: Color(0xFFF9E2AF),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              ...result.warnings.map((w) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('⚠ ',
                            style: TextStyle(color: Color(0xFFF9E2AF))),
                        Expanded(
                          child: Text(w,
                              style: const TextStyle(
                                  color: Color(0xFFCDD6F4), fontSize: 12)),
                        ),
                      ],
                    ),
                  )),
            ],
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: result.success
                ? const Color(0xFFA6E3A1)
                : const Color(0xFF89B4FA),
            foregroundColor: const Color(0xFF1E1E2E),
          ),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
