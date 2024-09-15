import 'package:buzz/provider/proviercolors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../appstaticdata/staticdata.dart';
import '../widgets/comuntitle.dart';

class MyDataSource extends DataTableSource {
  static const List<int> _displayIndexToRawIndex = <int>[0, 3, 4, 5, 6];

  late List<List<Comparable<Object>>> sortedData;
  void setData(List<List<Comparable<Object>>> rawData, int sortColumn,
      bool sortAscending) {
    sortedData = rawData.toList()
      ..sort((List<Comparable<Object>> a, List<Comparable<Object>> b) {
        final Comparable<Object> cellA = a[_displayIndexToRawIndex[sortColumn]];
        final Comparable<Object> cellB = b[_displayIndexToRawIndex[sortColumn]];
        return cellA.compareTo(cellB) * (sortAscending ? 1 : -1);
      });
    notifyListeners();
  }

  @override
  int get rowCount => sortedData.length;

  static DataCell cellFor(Object data) {
    String value;
    if (data is DateTime) {
      value =
          '${data.year}-${data.month.toString().padLeft(2, '0')}-${data.day.toString().padLeft(2, '0')}';
    } else {
      value = data.toString();
    }
    return DataCell(Text(value));
  }

  @override
  DataRow? getRow(int index) {
    return DataRow.byIndex(
      index: sortedData[index][0] as int,
      cells: <DataCell>[
        cellFor(
            'S${sortedData[index][1]}E${sortedData[index][2].toString().padLeft(2, '0')}'),
        cellFor(sortedData[index][3]),
        cellFor(sortedData[index][4]),
        cellFor(sortedData[index][5]),
        cellFor(sortedData[index][6]),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}

class DataTablesPage extends StatelessWidget {
  const DataTablesPage({super.key});

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Container(
      color: notifire!.getbgcolor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const ComunTitle(title: 'Data Table', path: "Forms & Table"),
            Container(
              margin: const EdgeInsets.all(padding),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                color: notifire!.getcontiner,
                boxShadow: boxShadow,
              ),
              child: const Row(
                children: [
                  Expanded(child: DataTableExample()),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(padding),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                color: notifire!.getcontiner,
                boxShadow: boxShadow,
              ),
              child: const Row(
                children: [
                  Expanded(
                    child: DataTablePaginationExample(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DataTableExample extends StatefulWidget {
  const DataTableExample({super.key});

  @override
  State<DataTableExample> createState() => _DataTableExampleState();
}

class _DataTableExampleState extends State<DataTableExample> {
  final MyDataSource dataSource = MyDataSource()..setData(episodes, 0, true);

  int _columnIndex = 0;
  bool _columnAscending = true;

  void _sort(int columnIndex, bool ascending) {
    setState(() {
      _columnIndex = columnIndex;
      _columnAscending = ascending;
      dataSource.setData(episodes, _columnIndex, _columnAscending);
    });
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Theme(
      data: Theme.of(context).copyWith(
          cardColor: notifire!.getcontiner,
          cardTheme: const CardTheme(elevation: 0),
          iconTheme: IconThemeData(color: notifire!.getMainText),
          textTheme: TextTheme(
              bodyMedium: TextStyle(color: notifire!.getMainText),
              bodySmall: TextStyle(color: notifire!.getMainText))),
      child: PaginatedDataTable(
        arrowHeadColor: notifire!.getMainText,
        header: Text("DataTable Example",
            style: mediumBlackTextStyle.copyWith(
                fontSize: 22,
                overflow: TextOverflow.ellipsis,
                color: notifire!.getMainText)),
        sortColumnIndex: _columnIndex,
        sortAscending: _columnAscending,
        columns: <DataColumn>[
          DataColumn(
            label: Text('Episode',
                style: mediumBlackTextStyle.copyWith(
                    overflow: TextOverflow.ellipsis,
                    color: notifire!.getMainText)),
            onSort: _sort,
          ),
          DataColumn(
            label: Text('Title',
                style: mediumBlackTextStyle.copyWith(
                    overflow: TextOverflow.ellipsis,
                    color: notifire!.getMainText)),
            onSort: _sort,
          ),
          DataColumn(
            label: Text('Director',
                style: mediumBlackTextStyle.copyWith(
                    overflow: TextOverflow.ellipsis,
                    color: notifire!.getMainText)),
            onSort: _sort,
          ),
          DataColumn(
            label: Text('Writer(s)',
                style: mediumBlackTextStyle.copyWith(
                    overflow: TextOverflow.ellipsis,
                    color: notifire!.getMainText)),
            onSort: _sort,
          ),
          DataColumn(
            label: Text('Air Date',
                style: mediumBlackTextStyle.copyWith(
                    overflow: TextOverflow.ellipsis,
                    color: notifire!.getMainText)),
            onSort: _sort,
          ),
        ],
        source: dataSource,
      ),
    );
  }
}

final List<List<Comparable<Object>>> episodes = <List<Comparable<Object>>>[
  <Comparable<Object>>[
    1,
    1,
    1,
    'Strange New Worlds',
    'Akiva Goldsman',
    'Akiva Goldsman, Alex Kurtzman, Jenny Lumet',
    DateTime(2022, 5, 5),
  ],
  <Comparable<Object>>[
    2,
    1,
    2,
    'Children of the Comet',
    'Maja Vrvilo',
    'Henry Alonso Myers, Sarah Tarkoff',
    DateTime(2022, 5, 12),
  ],
  <Comparable<Object>>[
    3,
    1,
    3,
    'Ghosts of Illyria',
    'Leslie Hope',
    'Akela Cooper, Bill Wolkoff',
    DateTime(2022, 5, 19),
  ],
  <Comparable<Object>>[
    4,
    1,
    4,
    'Memento Mori',
    'Dan Liu',
    'Davy Perez, Beau DeMayo',
    DateTime(2022, 5, 26),
  ],
  <Comparable<Object>>[
    5,
    1,
    5,
    'Spock Amok',
    'Rachel Leiterman',
    'Henry Alonso Myers, Robin Wasserman',
    DateTime(2022, 6, 2),
  ],
  <Comparable<Object>>[
    6,
    1,
    6,
    'Lift Us Where Suffering Cannot Reach',
    'Andi Armaganian',
    'Robin Wasserman, Bill Wolkoff',
    DateTime(2022, 6, 9),
  ],
  <Comparable<Object>>[
    7,
    1,
    7,
    'The Serene Squall',
    'Sydney Freeland',
    'Beau DeMayo, Sarah Tarkoff',
    DateTime(2022, 6, 16),
  ],
  <Comparable<Object>>[
    8,
    1,
    8,
    'The Elysian Kingdom',
    'Amanda Row',
    'Akela Cooper, Onitra Johnson',
    DateTime(2022, 6, 23),
  ],
  <Comparable<Object>>[
    9,
    1,
    9,
    'All Those Who Wander',
    'Christopher J. Byrne',
    'Davy Perez',
    DateTime(2022, 6, 30),
  ],
  <Comparable<Object>>[
    10,
    2,
    10,
    'A Quality of Mercy',
    'Chris Fisher',
    'Henry Alonso Myers, Akiva Goldsman',
    DateTime(2022, 7, 7),
  ],
  <Comparable<Object>>[
    11,
    2,
    1,
    'The Broken Circle',
    'Chris Fisher',
    'Henry Alonso Myers, Akiva Goldsman',
    DateTime(2023, 6, 15),
  ],
  <Comparable<Object>>[
    12,
    2,
    2,
    'Ad Astra per Aspera',
    'Valerie Weiss',
    'Dana Horgan',
    DateTime(2023, 6, 22),
  ],
  <Comparable<Object>>[
    13,
    2,
    3,
    'Tomorrow and Tomorrow and Tomorrow',
    'Amanda Row',
    'David Reed',
    DateTime(2023, 6, 29),
  ],
  <Comparable<Object>>[
    14,
    2,
    4,
    'Among the Lotus Eaters',
    'Eduardo SÃ¡nchez',
    'Kirsten Beyer, Davy Perez',
    DateTime(2023, 7, 6),
  ],
  <Comparable<Object>>[
    15,
    2,
    5,
    'Charades',
    'Jordan Canning',
    'Kathryn Lyn, Henry Alonso Myers',
    DateTime(2023, 7, 13),
  ],
  <Comparable<Object>>[
    16,
    2,
    6,
    'Lost in Translation',
    'Dan Liu',
    'Onitra Johnson, David Reed',
    DateTime(2023, 7, 20),
  ],
  <Comparable<Object>>[
    17,
    2,
    7,
    'Those Old Scientists',
    'Jonathan Frakes',
    'Kathryn Lyn, Bill Wolkoff',
    DateTime(2023, 7, 22),
  ],
  <Comparable<Object>>[
    18,
    2,
    8,
    'Under the Cloak of War',
    '',
    'Davy Perez',
    DateTime(2023, 7, 27),
  ],
  <Comparable<Object>>[
    19,
    2,
    9,
    'Subspace Rhapsody',
    '',
    'Dana Horgan, Bill Wolkoff',
    DateTime(2023, 8, 3),
  ],
  <Comparable<Object>>[
    20,
    2,
    10,
    'Hegemony',
    '',
    'Henry Alonso Myers',
    DateTime(2023, 8, 10),
  ],
];

class DataTablePaginationExample extends StatefulWidget {
  const DataTablePaginationExample({super.key});

  @override
  State<DataTablePaginationExample> createState() =>
      _DataTablePaginationExampleState();
}

class _DataTablePaginationExampleState
    extends State<DataTablePaginationExample> {
  int rowlagth = 10;

  @override
  Widget build(BuildContext context) {
    var tableRow = TableRow(context, children: []);
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Theme(
      data: Theme.of(context).copyWith(
          cardTheme: const CardTheme(elevation: 0),
          cardColor: notifire!.getcontiner,
          textTheme:
              TextTheme(bodySmall: TextStyle(color: notifire!.getMainText))),
      child: PaginatedDataTable(
        arrowHeadColor: notifire!.getMainText,
        header: Text("Pagination Example",
            style: mediumBlackTextStyle.copyWith(
                fontSize: 22,
                overflow: TextOverflow.ellipsis,
                color: notifire!.getMainText)),
        onRowsPerPageChanged: (perPage) {
          setState(() {
            rowlagth = perPage!;
          });
        },
        rowsPerPage: rowlagth,
        columns: <DataColumn>[
          DataColumn(
            label: Text('Country',
                style: mediumBlackTextStyle.copyWith(
                    overflow: TextOverflow.ellipsis,
                    color: notifire!.getMainText)),
            onSort: (columnIndex, ascending) {},
          ),
          DataColumn(
            label: Text('Code',
                style: mediumBlackTextStyle.copyWith(
                    overflow: TextOverflow.ellipsis,
                    color: notifire!.getMainText)),
          ),
          DataColumn(
            label: Text('Continent',
                style: mediumBlackTextStyle.copyWith(
                    overflow: TextOverflow.ellipsis,
                    color: notifire!.getMainText)),
          ),
        ],
        source: tableRow,
      ),
    );
  }
}

class TableRow extends DataTableSource {
  BuildContext context;
  TableRow(this.context, {required List<dynamic> children});
  @override
  DataRow? getRow(int index) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text("Cell $index",
          style: mediumBlackTextStyle.copyWith(
              overflow: TextOverflow.ellipsis, color: notifire!.getMainText))),
      DataCell(Text("Cell $index",
          style: mediumGreyTextStyle.copyWith(
              overflow: TextOverflow.ellipsis, color: notifire!.getMainText))),
      DataCell(Text("Cell $index",
          style: mediumGreyTextStyle.copyWith(
              overflow: TextOverflow.ellipsis, color: notifire!.getMainText))),
    ]);
  }

  @override
  bool get isRowCountApproximate => true;

  @override
  int get rowCount => 50;

  @override
  int get selectedRowCount => 0;
}
