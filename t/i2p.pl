sub i2p {
    my $in=shift;
    infix2pharmml::init;
    $infix2pharmml::noinput=1;
    my $xml=infix2pharmml::xmlify($in);
    my $twig=XML::Twig->new( pretty_print => 'indented'); 
    $twig->parse($xml);
    my $xml_indented=$twig->sprint;
    return $xml_indented;
}

1;
