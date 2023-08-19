class JobDetailsModel {
  final String companyLogo;
  final String jobName;
  final String companyName;
  final String location;
  final String description;
  final String salary;
  final List<String> chips;

  JobDetailsModel({
    required this.companyLogo,
    required this.jobName,
    required this.companyName,
    required this.location,
    required this.description,
    required this.salary,
    required this.chips,
  });
}