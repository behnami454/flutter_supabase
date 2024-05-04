import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseManager {
  static const String supabaseUrl = 'https://fszmicgacuftwaxzrydi.supabase.co';
  static const String supabaseApiKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZzem1pY2dhY3VmdHdheHpyeWRpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQ4MDY0MzIsImV4cCI6MjAzMDM4MjQzMn0.BuuIcFDZwtUF7FWehbna7KSrChm_s7UAJpRLdukvtko';

  final SupabaseClient client = SupabaseClient(supabaseUrl, supabaseApiKey);

  static final SupabaseManager _instance = SupabaseManager._internal();

  factory SupabaseManager() {
    return _instance;
  }

  SupabaseManager._internal();
}
