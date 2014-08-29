
array_wrapper* our_gsl_ran_shuffle(const gsl_rng* r, int* v, size_t n) {
    size_t cell_size = sizeof(int);
    array_wrapper *w = array_wrapper_alloc(n, awInt);
    memcpy((int*)w->data, v, n*cell_size);
    gsl_ran_shuffle(r, (int*)w->data, n, cell_size);
    return w;
}
