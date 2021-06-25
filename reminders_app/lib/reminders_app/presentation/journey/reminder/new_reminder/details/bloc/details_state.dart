class DetailsState {
  int date = 0;
  int time = 0;
  int priority = 0;
  bool hasDate = false;
  bool hasTime = false;

  DetailsState(
      {this.date, this.time, this.priority, this.hasDate, this.hasTime});

  DetailsState update({
    int date,
    int time,
    int priority,
    bool hasDate,
    bool hasTime,
  }) =>
      DetailsState(
          date: date ?? this.date,
          time: time ?? this.time,
          priority: priority ?? this.priority,
          hasDate: hasDate ?? this.hasDate,
          hasTime: hasTime ?? this.hasTime);
}
