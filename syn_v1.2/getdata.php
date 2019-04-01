<?php 
header('Content-Type: application/json');
if(isset($_GET['track_id'])) {

/* Spotify Application Client ID and Secret Key */
$client_id     = '5b76a404fdcb49a19814f6e0d26f4a4a'; 
$client_secret = 'b4f94a1f265c4e6ba9452baa5e835739'; 

/* Get Spotify Authorization Token */
$ch = curl_init();
curl_setopt($ch, CURLOPT_URL,            'https://accounts.spotify.com/api/token' );
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1 );
curl_setopt($ch, CURLOPT_POST,           1 );
curl_setopt($ch, CURLOPT_POSTFIELDS,     'grant_type=client_credentials' ); 
curl_setopt($ch, CURLOPT_HTTPHEADER,     array('Authorization: Basic '.base64_encode($client_id.':'.$client_secret))); 

$result=curl_exec($ch);
$json = json_decode($result, true);

//exit($json['access_token']);



/* Get Spotify Artist Photo */
//exec('curl -i "https://api.spotify.com/v1/audio-features/4gxukDJiwApNEgVIh4pHgT" -H "Accept: application/json" -H "Authorization: Bearer '.$json['access_token'].'" -H "Content-Type: application/json" 2>&1', $pp);

exec('curl "https://api.spotify.com/v1/audio-features/'.$_GET['track_id'].'" -H "Accept: application/json" -H "Content-Type: application/json" -H "Authorization: Bearer '.$json['access_token'].'"', $pp);
    
//echo($pp);
//echo json_decode(implode("\r\n", $pp));

$finalObject = implode("\r\n", $pp);

$page_content = preg_replace('/<(pre)(?:(?!<\/\1).)*?<\/\1>/s','',$finalObject);
echo($page_content);
    
    
$json2 = json_decode(implode("\r\n", $pp));
        
//echo(json_encode($json2));

} else {
    
    exit("You need to use a spotify track-ID");
}

?>
