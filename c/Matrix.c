gsl_matrix *gsl_matrix_hconcat(const gsl_matrix *A,
							   const gsl_matrix *B) {
	int colsA, colsB, rows;
	gsl_matrix_view Aview, Bview;
	gsl_matrix *C;

	if (A->size1 != B->size1) return NULL;
	rows = A->size1;
	colsA = A->size2;
	colsB = B->size2;

	C = gsl_matrix_alloc( rows, colsA + colsB);
	if (!C) return NULL;

	Aview = gsl_matrix_submatrix(C, 0, 0, rows, colsA);
	Bview = gsl_matrix_submatrix(C, 0, colsA, rows, colsB);

	gsl_matrix_memcpy(&Aview.matrix, A);
	gsl_matrix_memcpy(&Bview.matrix, B);

	return C;
}

gsl_matrix *gsl_matrix_vconcat(const gsl_matrix *A,
	                           const gsl_matrix *B) {
	int cols, rowsA, rowsB;
	gsl_matrix_view Aview, Bview;
	gsl_matrix *C;

	if (A->size2 != B->size2) return NULL;
	cols = A->size2;
	rowsA = A->size1;
	rowsB = B->size1;

	C = gsl_matrix_alloc( rowsA + rowsB, cols);
	if (!C) return NULL;

	Aview = gsl_matrix_submatrix(C, 0, 0, rowsA, cols);
	Bview = gsl_matrix_submatrix(C, rowsA, 0, rowsB, cols);

	gsl_matrix_memcpy(&Aview.matrix, A);
	gsl_matrix_memcpy(&Bview.matrix, B);

	return C;
}
