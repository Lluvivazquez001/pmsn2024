import 'package:flutter/material.dart';
import 'package:pmsn2024/database/movies_database.dart';
import 'package:pmsn2024/models/moviesdao.dart';
import 'package:pmsn2024/settings/global_values.dart';
import 'package:pmsn2024/views/movie_view.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class MovieViewItem extends StatefulWidget {
  MovieViewItem({super.key,required this.moviesDAO});

  MoviesDAO moviesDAO;

  @override
  State<MovieViewItem> createState() => _MovieViewItemState();
}

class _MovieViewItemState extends State<MovieViewItem> {
  MoviesDatabase? moviesDatabase; //inicializamos la variable que apunta a la base de datos

  @override
  void initState() {
    super.initState();
    moviesDatabase = MoviesDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.blueAccent),
      child: Column(
        children: [
          Row(
            //elemento que puede utilizar multiples elementos
            children: [
              //en el siguiente image.network vamos a tomar una de internet
              Image.network(
                'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/597777fd-3ab0-4ee2-bba9-a68a67f4befa/d9jyfj5-d9e67b5f-3c41-48ef-8996-a84cdd01b948.jpg/v1/fill/w_1600,h_2286,q_75,strp/poster_mi_vecino_totoro__personaje_1_by_vind7_d9jyfj5-fullview.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9MjI4NiIsInBhdGgiOiJcL2ZcLzU5Nzc3N2ZkLTNhYjAtNGVlMi1iYmE5LWE2OGE2N2Y0YmVmYVwvZDlqeWZqNS1kOWU2N2I1Zi0zYzQxLTQ4ZWYtODk5Ni1hODRjZGQwMWI5NDguanBnIiwid2lkdGgiOiI8PTE2MDAifV1dLCJhdWQiOlsidXJuOnNlcnZpY2U6aW1hZ2Uub3BlcmF0aW9ucyJdfQ.Ity7JcaVQCwtCK2VZU5rA6jIrVw28d9LM-RtHbFs89o',
                height: 100,
              ),
              Expanded(
                //va a ocupar un espacio definido
                child: ListTile(
                  title: Text(widget.moviesDAO.nameMovie!),
                  subtitle: Text(widget.moviesDAO.releaseDate!),
                ),
              ),
              IconButton(
                  onPressed: () {
                    WoltModalSheet.show(
                        context: context,
                        pageListBuilder: (context) => [
                              WoltModalSheetPage(
                                  child: MovieView(moviesDAO: widget.moviesDAO,) //mandamos llamar al movie_view
                        )
                      ]
                    );
                  },
                  icon: Icon(Icons.edit)),
              IconButton(
                  onPressed: () {
                    moviesDatabase!
                        .DELETE('tblmovies', widget.moviesDAO.idMovie!)
                        .then((value) {
                      //mandamos llamar la variable de bd
                      if (value > 0) {
                        GlobalValues.banUpdListMovies.value = !GlobalValues
                            .banUpdListMovies
                            .value; //mandamos llamar la bandera cuando se active
                        return QuickAlert.show(
                          context: context,
                          type: QuickAlertType.success,
                          text: 'Transaction Completed Successfully!',
                          autoCloseDuration: const Duration(seconds: 2),
                          showConfirmBtn: false,
                        );
                      } else {
                        return QuickAlert.show(
                          context: context,
                          type: QuickAlertType.success,
                          text: 'Something was wrong!',
                          autoCloseDuration: const Duration(seconds: 2),
                          showConfirmBtn: false,
                        );
                      }
                    });
                  },
                  icon: Icon(Icons.delete)),
            ],
          ),
          Divider(), //agregamos una linea divisoria
          Text(widget.moviesDAO.overview!),
        ],
      ),
    );
  }
}
