import 'package:taakitecture/taakitecture.dart';
import 'controller/financial_report_controller.dart';
import 'controller/rate_report_controller.dart';
import 'controller/report_controller.dart';
import 'controller/report_overview_controller.dart';
import 'controller/ticket_report_controller.dart';
import 'data/datasources/report_datasource.dart';
import 'data/datasources/report_overview_datasource.dart';
import 'data/repositories/report_overview_repository.dart';
import 'data/repositories/report_repository.dart';

class ReportOverviewBindings extends Injection {
  @override
  initController() {
    singleton(ReportOverviewController(sl<ReportOverviewRepository>()));
  }

  @override
  initDataSource() {
    singleton(ReportOverviewDatasource(sl()));
  }

  @override
  initRepository() {
    singleton(ReportOverviewRepository(sl<ReportOverviewDatasource>(), sl()));
  }
}

class TicketReportBindings extends Injection {
  @override
  initController() {
    singleton(TicketReportController(sl<ReportOverviewRepository>()));
  }

  @override
  initDataSource() {
    singleton(ReportOverviewDatasource(sl()));
  }

  @override
  initRepository() {
    singleton(ReportOverviewRepository(sl<ReportOverviewDatasource>(), sl()));
  }
}

class RateReportBindings extends Injection {
  @override
  initController() {
    singleton<ReportController>(RateReportController(sl<ReportRepository>()));
  }

  @override
  initDataSource() {
    singleton(ReportDatasource(sl()));
  }

  @override
  initRepository() {
    singleton(ReportRepository(sl<ReportDatasource>(), sl()));
  }
}

class FinancialBindings extends Injection {
  @override
  initController() {
    singleton<ReportController>(FinancialReportController(sl<ReportRepository>()));
  }

  @override
  initDataSource() {
    singleton(ReportDatasource(sl()));
  }

  @override
  initRepository() {
    singleton(ReportRepository(sl<ReportDatasource>(), sl()));
  }
}
