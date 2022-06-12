import { Component } from '@angular/core';

import { TranslateService } from '@ngx-translate/core';
// import { NzI18nService } from 'ng-zorro-antd/i18n';

@Component({
  selector: 'app-root',
  template: `
    <router-outlet></router-outlet>
    <ngx-spinner></ngx-spinner>
  `
})
export class AppComponent {
  constructor(
    public translate: TranslateService,
    // private i18n: NzI18nService
  ) {
    // i18n.setLocale({
    //   locale: 'vi',
    //   DatePicker: {
    //     lang: {
    //       today: string,
    //       now: string,
    //       backToToday: string,
    //       ok: string,
    //       clear: string,
    //       month: string,
    //       year: string,
    //       timeSelect: string,
    //       dateSelect: string,
    //       monthSelect: string,
    //       yearSelect: string,
    //       decadeSelect: string,
    //       yearFormat: string,
    //       monthFormat?: string,
    //       dateFormat: string,
    //       dayFormat: string,
    //       dateTimeFormat: string,
    //       monthBeforeYear?: boolean,
    //       previousMonth: string,
    //       nextMonth: string,
    //       previousYear: string,
    //       nextYear: string,
    //       previousDecade: string,
    //       nextDecade: string,
    //       previousCentury: string,
    //       nextCentury: string,
    //       yearPlaceholder: 'Chọn tháng',
    //       quarterPlaceholder: 'Chọn quý',
    //       monthPlaceholder: 'Chọn tháng',
    //       weekPlaceholder: 'Chọn tuần',
    //       rangePlaceholder: ['Thời điểm bắt đầu', 'Thời điểm kết thúc'],
    //       rangeYearPlaceholder: ['Năm bắt đầu', 'Năm kết thúc'],
    //       rangeMonthPlaceholder: ['Tháng bắt đầu', 'Tháng kết thúc'],
    //       rangeWeekPlaceholder: ['Tuần bắt đầu', 'Tuần kết thúc']
    //     },
    //     timePickerLocale: {
    //       placeholder?: string,
    //       rangePlaceholder?: string[]
    //     }
    //   }
    // });
    translate.setDefaultLang('vi');
    translate.use('vi');
  }
}
