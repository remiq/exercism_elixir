defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @type weekday ::
      :monday | :tuesday | :wednesday
    | :thursday | :friday | :saturday | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date
  def meetup(year, month, weekday, schedule) do
    case {schedule, weekdays(year, month, weekday)} do
      {:first, [day | _]} -> {year, month, day}
      {:second, [_, day | _]} -> {year, month, day}
      {:third, [_, _, day | _]} -> {year, month, day}
      {:fourth, [_, _, _, day | _]} -> {year, month, day}
      {:last, days} -> {year, month, List.last(days)}
      {:teenth, days} -> {year, month, Enum.find(days, fn d -> d in 13..19 end)}
    end
  end

  @doc """
  Returns list of day-of-month that matches `weekday` for selected `year` and `month`.
  """
  @spec weekdays(pos_integer, pos_integer, pos_integer) :: [pos_integer]
  def weekdays(year, month, weekday) do
    month_days(year, month)
    |> Enum.reduce({1, []}, fn doy, {dom, acc} ->
      case doy2dom(year, doy) do
        ^weekday -> {dom + 1, acc ++ [dom]}
        _ -> {dom + 1, acc}
      end
    end)
    |> (fn {_, days} -> days end).()
  end

  @spec month_days(pos_integer, pos_integer) :: Range.t
  # length of months for 2013
  [
    31, 28, 31, 30, 31, 30,
    31, 31, 30, 31, 30, 31
  ] |> Enum.reduce({1, 1}, fn days, {month, sum_days} ->
    def month_days(2013, unquote(month)), do: unquote(sum_days)..unquote(sum_days + days - 1)
    {month + 1, sum_days + days}
  end)

  @doc """
  Day of year to day of month
  Year 2013 only.
  """
  def doy2dom(2013, doy) when rem(doy, 7) == 0, do: :monday
  def doy2dom(2013, doy) when rem(doy, 7) == 1, do: :tuesday
  def doy2dom(2013, doy) when rem(doy, 7) == 2, do: :wednesday
  def doy2dom(2013, doy) when rem(doy, 7) == 3, do: :thursday
  def doy2dom(2013, doy) when rem(doy, 7) == 4, do: :friday
  def doy2dom(2013, doy) when rem(doy, 7) == 5, do: :saturday
  def doy2dom(2013, doy) when rem(doy, 7) == 6, do: :sunday

end
