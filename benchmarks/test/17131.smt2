(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

; 统一获取长度的函数
(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

; 统一获取元素的函数
(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var2890 0)
(declare-sort var1554 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun mId/539007593 (var2890) Int)
(declare-fun append/-901862667 (String Int) String)
(declare-fun mVersion/539007593 (var2890) String)
(declare-fun mTwoWay/539007593 (var2890) Bool)
(declare-fun append/-388390247 (String Bool) String)
(declare-fun mEvent/539007593 (var2890) Bool)
(declare-fun mBroken/539007593 (var2890) Bool)
(declare-fun mPayload/539007593 (var2890) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(declare-fun mData/539007593 (var2890) var1554)
(declare-fun cast-from-var2890-to-var1554 (var2890) var1554)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2890 var2890)
(declare-const var2940 var2890) ; Statement: r1 := @this: org.apache.dubbo.remoting.exchange.Request 
(assert (not (= var2940 null-var2890)))
(define-const var618 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var618)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var618!1 String)
(assert (= var618!1 ""))
(assert true)
(define-const var3839 String (append/672562846 var618!1 "Request [id=")) ; Statement: $r2 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Request [id=") 
(declare-const var618!2 String)
(assert (= var618!2 (str.++ var618!1 "Request [id=")))
(define-const var1167 Int (mId/539007593 var2940)) ; Statement: $l0 = r1.<org.apache.dubbo.remoting.exchange.Request: long mId> 
(assert true)
(define-const var3412 String (append/-901862667 var3839 var1167)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l0) 
(declare-const var3839!1 String)
(assert (str.prefixof var3839 var3839!1))
(assert true)
(define-const var962 String (append/672562846 var3412 ", version=")) ; Statement: $r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", version=") 
(declare-const var3412!1 String)
(assert (= var3412!1 (str.++ var3412 ", version=")))
(define-const var879 String (mVersion/539007593 var2940)) ; Statement: $r4 = r1.<org.apache.dubbo.remoting.exchange.Request: java.lang.String mVersion> 
(assert true)
(define-const var3544 String (append/672562846 var962 var879)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var962!1 String)
(assert (= var962!1 (str.++ var962 var879)))
(assert true)
(define-const var2528 String (append/672562846 var3544 ", twoWay=")) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", twoWay=") 
(declare-const var3544!1 String)
(assert (= var3544!1 (str.++ var3544 ", twoWay=")))
(define-const var1368 Bool (mTwoWay/539007593 var2940)) ; Statement: $z0 = r1.<org.apache.dubbo.remoting.exchange.Request: boolean mTwoWay> 
(assert true)
(define-const var14 String (append/-388390247 var2528 var1368)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>($z0) 
(declare-const var2528!1 String)
(assert (str.prefixof var2528 var2528!1))
(assert true)
(define-const var2514 String (append/672562846 var14 ", event=")) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", event=") 
(declare-const var14!1 String)
(assert (= var14!1 (str.++ var14 ", event=")))
(define-const var323 Bool (mEvent/539007593 var2940)) ; Statement: $z1 = r1.<org.apache.dubbo.remoting.exchange.Request: boolean mEvent> 
(assert true)
(define-const var3189 String (append/-388390247 var2514 var323)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>($z1) 
(declare-const var2514!1 String)
(assert (str.prefixof var2514 var2514!1))
(assert true)
(define-const var1891 String (append/672562846 var3189 ", broken=")) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", broken=") 
(declare-const var3189!1 String)
(assert (= var3189!1 (str.++ var3189 ", broken=")))
(define-const var957 Bool (mBroken/539007593 var2940)) ; Statement: $z2 = r1.<org.apache.dubbo.remoting.exchange.Request: boolean mBroken> 
(assert true)
(define-const var1617 String (append/-388390247 var1891 var957)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>($z2) 
(declare-const var1891!1 String)
(assert (str.prefixof var1891 var1891!1))
(assert true)
(define-const var1455 String (append/672562846 var1617 ", mPayload=")) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", mPayload=") 
(declare-const var1617!1 String)
(assert (= var1617!1 (str.++ var1617 ", mPayload=")))
(define-const var2331 Int (mPayload/539007593 var2940)) ; Statement: $i1 = r1.<org.apache.dubbo.remoting.exchange.Request: int mPayload> 
(assert true)
(define-const var1515 String (append/-1001720160 var1455 var2331)) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i1) 
(declare-const var1455!1 String)
(assert (str.prefixof var1455 var1455!1))
(assert true)
(define-const var3820 String (append/672562846 var1515 ", data=")) ; Statement: $r17 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", data=") 
(declare-const var1515!1 String)
(assert (= var1515!1 (str.++ var1515 ", data=")))
(define-const var1379 var1554 (mData/539007593 var2940)) ; Statement: $r15 = r1.<org.apache.dubbo.remoting.exchange.Request: java.lang.Object mData> 
 ; Statement: if $r15 != r1 goto $r16 = r1.<org.apache.dubbo.remoting.exchange.Request: java.lang.Object mData> 
(assert (not (not (= var1379 (cast-from-var2890-to-var1554 var2940))))) ; Negate: Cond: $r15 != r1  
(define-const var584 String "this") ; Statement: $r21 = "this" 
 ; Statement: goto [?= $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r21)] 
(assert true) ; Non Conditional
(assert true)
(define-const var1404 String (append/672562846 var3820 var584)) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r21) 
(declare-const var3820!1 String)
(assert (= var3820!1 (str.++ var3820 var584)))
(assert true)
(define-const var1621 String (append/672562846 var1404 "]")) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("]") 
(declare-const var1404!1 String)
(assert (= var1404!1 (str.++ var1404 "]")))
(assert true)
(define-const var1520 String (toString/-2075883882 var1621)) ; Statement: $r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r20 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), mId/539007593=([org.apache.dubbo.remoting.exchange.Request], long), append/-901862667=([java.lang.StringBuilder, long], java.lang.StringBuilder), mVersion/539007593=([org.apache.dubbo.remoting.exchange.Request], java.lang.String), mTwoWay/539007593=([org.apache.dubbo.remoting.exchange.Request], boolean), append/-388390247=([java.lang.StringBuilder, boolean], java.lang.StringBuilder), mEvent/539007593=([org.apache.dubbo.remoting.exchange.Request], boolean), mBroken/539007593=([org.apache.dubbo.remoting.exchange.Request], boolean), mPayload/539007593=([org.apache.dubbo.remoting.exchange.Request], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), mData/539007593=([org.apache.dubbo.remoting.exchange.Request], java.lang.Object), cast-from-var2890-to-var1554=([org.apache.dubbo.remoting.exchange.Request], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2890=org.apache.dubbo.remoting.exchange.Request, var2940=r1, var618=$r0, var3839=$r2, var1167=$l0, var3412=$r3, var962=$r5, var879=$r4, var3544=$r6, var2528=$r7, var1368=$z0, var14=$r8, var2514=$r9, var323=$z1, var3189=$r10, var1891=$r11, var957=$z2, var1617=$r12, var1455=$r13, var2331=$i1, var1515=$r14, var3820=$r17, var1554=java.lang.Object, var1379=$r15, var584=$r21, var1404=$r18, var1621=$r19, var1520=$r20}
; {org.apache.dubbo.remoting.exchange.Request=var2890, r1=var2940, $r0=var618, $r2=var3839, $l0=var1167, $r3=var3412, $r5=var962, $r4=var879, $r6=var3544, $r7=var2528, $z0=var1368, $r8=var14, $r9=var2514, $z1=var323, $r10=var3189, $r11=var1891, $z2=var957, $r12=var1617, $r13=var1455, $i1=var2331, $r14=var1515, $r17=var3820, java.lang.Object=var1554, $r15=var1379, $r21=var584, $r18=var1404, $r19=var1621, $r20=var1520}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(long)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 10,"<java.lang.StringBuilder: java.lang.StringBuilder append(long)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.remoting.exchange.Request;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Request [id=");	$l0 = r1.<org.apache.dubbo.remoting.exchange.Request: long mId>;	$r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l0);	$r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", version=");	$r4 = r1.<org.apache.dubbo.remoting.exchange.Request: java.lang.String mVersion>;	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", twoWay=");	$z0 = r1.<org.apache.dubbo.remoting.exchange.Request: boolean mTwoWay>;	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>($z0);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", event=");	$z1 = r1.<org.apache.dubbo.remoting.exchange.Request: boolean mEvent>;	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>($z1);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", broken=");	$z2 = r1.<org.apache.dubbo.remoting.exchange.Request: boolean mBroken>;	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>($z2);	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", mPayload=");	$i1 = r1.<org.apache.dubbo.remoting.exchange.Request: int mPayload>;	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i1);	$r17 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", data=");	$r15 = r1.<org.apache.dubbo.remoting.exchange.Request: java.lang.Object mData>;	if $r15 != r1 goto $r16 = r1.<org.apache.dubbo.remoting.exchange.Request: java.lang.Object mData>;	$r21 = "this";	goto [?= $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r21)];	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r21);	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("]");	$r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.String toString()>();	return $r20
;block_num 3