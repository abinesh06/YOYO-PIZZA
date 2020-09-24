<?php
require 'connection.php';
function track_my_id($id){
    
        $conn=database_open();
    	$sql="SELECT * FROM yoyo_orders INNER JOIN user_details ON yoyo_orders.user_id=user_details.user_id WHERE yoyo_orders.order_id=:order_id";
    	$stmt = $conn->prepare($sql); 
    	$stmt->bindParam(':order_id', $id);
    	$stmt->execute();
    	if($stmt->rowCount()>0)
    	{
    	while($row= $stmt->fetch(PDO::FETCH_BOTH))
    			 {
               $data='Name : '.$row['user_name'].'<br> Order ID : '.$row['order_id'].'<br> Items : '.$row['order_items'].'<br> Address :'.$row['user_address'].'<br> Status : '.$row['order_status'];
    			}
    	}
        else {
         $data='Sorry no such Order exists ....';
    	}		
      return $data ;
    
    
}



function get_chatbot_msg(){

        	$msg = strtolower($_POST["message_sent"]);
        	$prev_ques = strtolower($_POST["prev_ques"]);
        	$items = strtolower($_POST["items"]);
        	$name_in_order = strtolower($_POST["name_in_order"]);
        	$delivery_addr = strtolower($_POST["delivery_addr"]);
        	$phone = strtolower($_POST["phone"]);
        	
        	
        	$menu_list=array("peppy paneer pizza","mexican green wave pizza","margherita pizza","cheese burger","double meat burger","potato corn burger","carrot cake","black forest","mango cake");
        	$menu_category=array("pizza","burger","desserts");
        	$cat_list = array (
        	  array("peppy paneer pizza","mexican green wave pizza","margherita pizza"),
        	  array("cheese burger","double meat burger","potato corn burger"),
        	  array("carrot cake","black forest","mango cake"),
        	);
        
        	if($msg==''){
        		$category_list ='Welcome to Yo Yo Pizza!<br> Pick your Item,<br> ';
        		for($j=0;$j<count($menu_category);$j++){
        			$category_list=$category_list.$menu_category[$j].'<br> ';
        		}
        		$data= ["message" => $category_list, "prev_ques" => $prev_ques, "items" => $items, "name_in_order" => $name_in_order, "delivery_addr" => $delivery_addr, "phone" => $phone];
        		return $data;
        	     }




    switch($prev_ques)
           {
            case "quantity":
                   	$arr = explode(" ",$msg);
        	     	$flag=0;
        	    	for($i=0;$i<count($arr);$i++){
        			if(is_numeric($arr[$i])){
        				$items=$items.'-'.$arr[$i].', ';
        				$prev_ques='';
        				$flag=1;
        			}
            		}
            		if($flag==0){
            			$data= ["message" => "We expect a numeric Value!", "prev_ques" => $prev_ques, "items" => $items, "name_in_order" => $name_in_order, "delivery_addr" => $delivery_addr, "phone" => $phone];
            			return $data;
            		}
            		else{
            		    $prev_ques='add_list';
            			$data= ["message" => "Would you like to continue the Purchase? (Yes/No)", "prev_ques" => $prev_ques, "items" => $items, "name_in_order" => $name_in_order, "delivery_addr" => $delivery_addr, "phone" => $phone];
            			return $data;
            		}
    
               break;
           
           
           
    	    case "add_list":
    	       		if(strpos($msg, 'yes') !== false){
            			$prev_ques='';
            			$category_list = 'Pick your Item,<br>';
            			for($j=0;$j<count($menu_category);$j++){
            				$category_list=$category_list.$menu_category[$j].'<br>';
            			}
            			$data= ["message" => $category_list, "prev_ques" => $prev_ques, "items" => $items, "name_in_order" => $name_in_order, "delivery_addr" => $delivery_addr, "phone" => $phone];
            			return $data;
            		}
            		else{
            			$prev_ques='place_order';
            			$data= ["message" => "Would you like to place the Order? (Yes/No)", "prev_ques" => $prev_ques, "items" => $items, "name_in_order" => $name_in_order, "delivery_addr" => $delivery_addr, "phone" => $phone];
            			return $data;
            		}
    
    			break;
    			      
    			      
    			       
    	     case "place_order":
                		if(strpos($msg, 'yes') !== false){
                			$prev_ques='get_name';
                			$data= ["message" => 'Kindly type us Your name ?', "prev_ques" => $prev_ques, "items" => $items, "name_in_order" => $name_in_order, "delivery_addr" => $delivery_addr, "phone" => $phone];
                			return $data;
                		}
                		else{
                			$prev_ques='';
                			$items='';
                			$data= ["message" => "Sorry to say that Your Order has been cancelled !! Kindly Check back Again .", "prev_ques" => $prev_ques, "items" => $items, "name_in_order" => $name_in_order, "delivery_addr" => $delivery_addr, "phone" => $phone];
                			return $data;
                		}
        			break;
        			     
        			     
        			       
            case "get_name":
                        	$name_in_order=$msg;
                			$prev_ques='get_address';
                			$data= ["message" => 'Would you please give the Delivery Address?', "prev_ques" => $prev_ques, "items" => $items, "name_in_order" => $name_in_order, "delivery_addr" => $delivery_addr, "phone" => $phone];
                			return $data;
        			break;
        			       
        			       
        			       
          case "get_address":
                         	$delivery_addr=$msg;
                			$prev_ques='get_phone';
                			$data= ["message" => 'Would you please give your Phone Number?', "prev_ques" => $prev_ques, "items" => $items, "name_in_order" => $name_in_order, "delivery_addr" => $delivery_addr, "phone" => $phone];
                			return $data;
    			break;       
    	   case "get_phone":
                    	$phone=$msg;
            			$prev_ques='order_confirmation';
            			$data= ["message" => 'Can We Confirm the Order? (Yes/No)', "prev_ques" => $prev_ques, "items" => $items, "name_in_order" => $name_in_order, "delivery_addr" => $delivery_addr, "phone" => $phone];
            			return $data;
    			break;
    			       
    	   case "order_confirmation":
            if(strpos($msg, 'yes') !== false || strpos($msg, 'ok') !== false || strpos($msg, 'okay') !== false || strpos($msg, 'conform') !== false || strpos($msg, 'confirm') !== false
            || strpos($msg, 'conformation') !== false || strpos($msg, 'confirmation') !== false || strpos($msg, 'confirming') !== false || strpos($msg, 'conforming') !== false ||
            strpos($msg, 'conformed') !== false || strpos($msg, 'confirmed') !== false){
            $prev_ques='';
        	$conn=database_open();
            date_default_timezone_set('Asia/Kolkata');
            $date = date('Y-m-d H:i:s');  				
        	$sql="select count(user_phone) as count from user_details where user_phone=:user_phone";
    		$stmt = $conn->prepare($sql); 
    		$stmt->bindParam(':user_phone',$phone );
    		$stmt->execute();
    		$row = $stmt->fetch(PDO::FETCH_BOTH);	
    		$cus_count=$row["count"];	
    		if($cus_count==0){
    			
    			
            $sql="UPDATE `auto_generation` SET `user_id`=`user_id`+1";
    		$stmt = $conn->prepare($sql); 
    		$stmt->execute();
    		
    		
    		$sql="select user_id from auto_generation";
    		$stmt = $conn->prepare($sql); 
    		$stmt->execute();
    		$row = $stmt->fetch(PDO::FETCH_BOTH);
    		$user=$row["user_id"];
    		$id='USER'.$user;
    
    
    
    
    
    		$sql="insert into user_details(`user_id`,`user_name`,`user_phone`,`user_address`,`user_added_on`) values(:user_id,:user_name,:user_phone,:user_address,:user_added_on)";
    		$stmt = $conn->prepare($sql); 
    		$stmt->bindParam(':user_id',$id );
    
    		$stmt->bindParam(':user_added_on', $date);
    		$stmt->bindParam(':user_name',$name_in_order );
    		
    		$stmt->bindParam(':user_phone', $phone);
    		$stmt->bindParam(':user_address', $delivery_addr);
            $stmt->execute();
    
    
    
          }	
    	  
    
    	    $sql="select user_id from user_details where user_phone=:user_phone";
    		$stmt = $conn->prepare($sql); 
    		$stmt->bindParam(':user_phone',$phone );
    		$stmt->execute();
    		$row = $stmt->fetch(PDO::FETCH_BOTH);
    		$user=$row["user_id"];
    		
    		$sql="UPDATE `user_details` SET `total_orders`=`total_orders`+1";
    		$stmt = $conn->prepare($sql); 
    		$stmt->execute();
    		
    		
            $sql="UPDATE `auto_generation` SET `order_id`=`order_id`+1";
    		$stmt = $conn->prepare($sql); 
    		$stmt->execute();
    		
    		
    		$sql="select order_id from auto_generation";
    		$stmt = $conn->prepare($sql); 
    		$stmt->execute();
    		$row = $stmt->fetch(PDO::FETCH_BOTH);
    		$ans=$row["order_id"];
    		$id='ORD'.$ans;	
            $ord_status='ordered';
      		 
    		$sql="insert into yoyo_orders(`order_id`,`order_items`,`order_status`,`user_id`,`order_date`) values(:order_id,:order_items,:order_status,:user_id,:order_date)";
    		$stmt = $conn->prepare($sql); 
    		$stmt->bindParam(':order_id',$id );
    
    		$stmt->bindParam(':order_status', $ord_status);
    		$stmt->bindParam(':order_items',$items );
    		$stmt->bindParam(':user_id',$user );
    		$stmt->bindParam(':order_date', $date);
            $stmt->execute();  
            $data= ["message" => 'Your Purchase  '.$items.' was successful .<br> Your Order ID is : '.$id.' <br> Seize Your moment !!! <br> Have a Pleasant Day !', "prev_ques" => $prev_ques
            , "items" => $items, "name_in_order" => $name_in_order, "delivery_addr" => $delivery_addr, "phone" => $phone];	
                				
            return $data;
    			}
    			else{
    				$prev_ques='';
    				$items='';
    				$data= ["message" => "Sorry to say that Your Order has been cancelled !! Kindly Check back Again .", "prev_ques" => $prev_ques, "items" => $items, "name_in_order" => $name_in_order, "delivery_addr" => $delivery_addr, "phone" => $phone];
    				return $data;
    			}
    			break;
     }
     for($i=0;$i<count($menu_list);$i++){
    		if(strpos($msg, $menu_list[$i]) !== false){
    
    		$items=$items.$menu_list[$i];
    		$prev_ques='quantity';
    		$data= ["message" => "How many ".$menu_list[$i]."s do you like to have?", "prev_ques" => $prev_ques, "items" => $items, "name_in_order" => $name_in_order, "delivery_addr" => $delivery_addr, "phone" => $phone];
    		return $data;
    		break;
    		
    		}
    	}
    
    
    
    	for($i=0;$i<count($menu_category);$i++){
    		if(strpos($msg, $menu_category[$i]) !== false){
    
    		$category_list = 'Our '.$menu_category[$i].' varieties ,<br>';
    		for($j=0;$j<count($cat_list[$i]);$j++){
    			$category_list=$category_list.$cat_list[$i][$j].'<br>';
    		}
    		$category_list = $category_list.'Kindly Pick one!';
    		$data= ["message" => $category_list, "prev_ques" => $prev_ques, "items" => $items, "name_in_order" => $name_in_order, "delivery_addr" => $delivery_addr, "phone" => $phone];
    		return $data;
    		break;
    		
    		}
    	}
    
    
    
    	$data= ["message" => "Applogies for inconvenience !! We can't process Your Request, Kindly visit back again !!!", "prev_ques" => $prev_ques, "items" => $items, "name_in_order" => $name_in_order, "delivery_addr" => $delivery_addr, "phone" => $phone];
    	return $data;

}

if(isset($_POST['track_my_id'])){


$data_res=track_my_id($_POST['track_my_id']);
echo $data_res;
}
else {
$data_res = get_chatbot_msg();    
    
echo json_encode($data_res);
}

$conn=null;
?>