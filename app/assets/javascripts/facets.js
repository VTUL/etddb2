$(document).ready(function () {
    /*
     * For browsers WITH javascript minimize facets, otherwise they will
     *  all be displayed
     */
    $facets = $(".minified");
    $facets.each(function() {
        $(this).css('display', 'none');
    });

    $('.facet_title').collapser({
        target: 'next',
        targetOnly: 'ul',
        effect: 'slide',
        changeText: 0,
        expandClass: 'expand',
        collapseClass: 'collapse'
    });
});