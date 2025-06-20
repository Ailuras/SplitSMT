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

(declare-sort var679 0)
(declare-sort var551 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun mId/539007593 (var679) Int)
(declare-fun append/-901862667 (String Int) String)
(declare-fun mVersion/539007593 (var679) String)
(declare-fun mTwoWay/539007593 (var679) Bool)
(declare-fun append/-388390247 (String Bool) String)
(declare-fun mEvent/539007593 (var679) Bool)
(declare-fun mBroken/539007593 (var679) Bool)
(declare-fun mPayload/539007593 (var679) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(declare-fun mData/539007593 (var679) var551)
(declare-fun cast-from-var679-to-var551 (var679) var551)
(declare-fun var679_safeToString/-2050842553 (var551) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var679 var679)
(declare-const var1523 var679) ; Statement: r1 := @this: org.apache.dubbo.remoting.exchange.Request 
(assert (not (= var1523 null-var679)))
(define-const var428 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var428)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var428!1 String)
(assert (= var428!1 ""))
(assert true)
(define-const var32 String (append/672562846 var428!1 "Request [id=")) ; Statement: $r2 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Request [id=") 
(declare-const var428!2 String)
(assert (= var428!2 (str.++ var428!1 "Request [id=")))
(define-const var3010 Int (mId/539007593 var1523)) ; Statement: $l0 = r1.<org.apache.dubbo.remoting.exchange.Request: long mId> 
(assert true)
(define-const var1534 String (append/-901862667 var32 var3010)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l0) 
(declare-const var32!1 String)
(assert (str.prefixof var32 var32!1))
(assert true)
(define-const var3212 String (append/672562846 var1534 ", version=")) ; Statement: $r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", version=") 
(declare-const var1534!1 String)
(assert (= var1534!1 (str.++ var1534 ", version=")))
(define-const var3772 String (mVersion/539007593 var1523)) ; Statement: $r4 = r1.<org.apache.dubbo.remoting.exchange.Request: java.lang.String mVersion> 
(assert true)
(define-const var365 String (append/672562846 var3212 var3772)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var3212!1 String)
(assert (= var3212!1 (str.++ var3212 var3772)))
(assert true)
(define-const var2516 String (append/672562846 var365 ", twoWay=")) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", twoWay=") 
(declare-const var365!1 String)
(assert (= var365!1 (str.++ var365 ", twoWay=")))
(define-const var2671 Bool (mTwoWay/539007593 var1523)) ; Statement: $z0 = r1.<org.apache.dubbo.remoting.exchange.Request: boolean mTwoWay> 
(assert true)
(define-const var3112 String (append/-388390247 var2516 var2671)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>($z0) 
(declare-const var2516!1 String)
(assert (str.prefixof var2516 var2516!1))
(assert true)
(define-const var2706 String (append/672562846 var3112 ", event=")) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", event=") 
(declare-const var3112!1 String)
(assert (= var3112!1 (str.++ var3112 ", event=")))
(define-const var3434 Bool (mEvent/539007593 var1523)) ; Statement: $z1 = r1.<org.apache.dubbo.remoting.exchange.Request: boolean mEvent> 
(assert true)
(define-const var1288 String (append/-388390247 var2706 var3434)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>($z1) 
(declare-const var2706!1 String)
(assert (str.prefixof var2706 var2706!1))
(assert true)
(define-const var3328 String (append/672562846 var1288 ", broken=")) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", broken=") 
(declare-const var1288!1 String)
(assert (= var1288!1 (str.++ var1288 ", broken=")))
(define-const var2376 Bool (mBroken/539007593 var1523)) ; Statement: $z2 = r1.<org.apache.dubbo.remoting.exchange.Request: boolean mBroken> 
(assert true)
(define-const var2180 String (append/-388390247 var3328 var2376)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>($z2) 
(declare-const var3328!1 String)
(assert (str.prefixof var3328 var3328!1))
(assert true)
(define-const var2141 String (append/672562846 var2180 ", mPayload=")) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", mPayload=") 
(declare-const var2180!1 String)
(assert (= var2180!1 (str.++ var2180 ", mPayload=")))
(define-const var2439 Int (mPayload/539007593 var1523)) ; Statement: $i1 = r1.<org.apache.dubbo.remoting.exchange.Request: int mPayload> 
(assert true)
(define-const var2411 String (append/-1001720160 var2141 var2439)) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i1) 
(declare-const var2141!1 String)
(assert (str.prefixof var2141 var2141!1))
(assert true)
(define-const var2500 String (append/672562846 var2411 ", data=")) ; Statement: $r17 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", data=") 
(declare-const var2411!1 String)
(assert (= var2411!1 (str.++ var2411 ", data=")))
(define-const var274 var551 (mData/539007593 var1523)) ; Statement: $r15 = r1.<org.apache.dubbo.remoting.exchange.Request: java.lang.Object mData> 
 ; Statement: if $r15 != r1 goto $r16 = r1.<org.apache.dubbo.remoting.exchange.Request: java.lang.Object mData> 
(assert (not (= var274 (cast-from-var679-to-var551 var1523)))) ; Cond: $r15 != r1 
(define-const var2175 var551 (mData/539007593 var1523)) ; Statement: $r16 = r1.<org.apache.dubbo.remoting.exchange.Request: java.lang.Object mData> 
(define-const var1698 String (var679_safeToString/-2050842553 var2175)) ; Statement: $r21 = staticinvoke <org.apache.dubbo.remoting.exchange.Request: java.lang.String safeToString(java.lang.Object)>($r16) 
(assert true) ; Non Conditional
(assert true)
(define-const var2183 String (append/672562846 var2500 var1698)) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r21) 
(declare-const var2500!1 String)
(assert (= var2500!1 (str.++ var2500 var1698)))
(assert true)
(define-const var546 String (append/672562846 var2183 "]")) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("]") 
(declare-const var2183!1 String)
(assert (= var2183!1 (str.++ var2183 "]")))
(assert true)
(define-const var3373 String (toString/-2075883882 var546)) ; Statement: $r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r20 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), mId/539007593=([org.apache.dubbo.remoting.exchange.Request], long), append/-901862667=([java.lang.StringBuilder, long], java.lang.StringBuilder), mVersion/539007593=([org.apache.dubbo.remoting.exchange.Request], java.lang.String), mTwoWay/539007593=([org.apache.dubbo.remoting.exchange.Request], boolean), append/-388390247=([java.lang.StringBuilder, boolean], java.lang.StringBuilder), mEvent/539007593=([org.apache.dubbo.remoting.exchange.Request], boolean), mBroken/539007593=([org.apache.dubbo.remoting.exchange.Request], boolean), mPayload/539007593=([org.apache.dubbo.remoting.exchange.Request], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), mData/539007593=([org.apache.dubbo.remoting.exchange.Request], java.lang.Object), cast-from-var679-to-var551=([org.apache.dubbo.remoting.exchange.Request], java.lang.Object), var679_safeToString/-2050842553=([java.lang.Object], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var679=org.apache.dubbo.remoting.exchange.Request, var1523=r1, var428=$r0, var32=$r2, var3010=$l0, var1534=$r3, var3212=$r5, var3772=$r4, var365=$r6, var2516=$r7, var2671=$z0, var3112=$r8, var2706=$r9, var3434=$z1, var1288=$r10, var3328=$r11, var2376=$z2, var2180=$r12, var2141=$r13, var2439=$i1, var2411=$r14, var2500=$r17, var551=java.lang.Object, var274=$r15, var2175=$r16, var1698=$r21, var2183=$r18, var546=$r19, var3373=$r20}
; {org.apache.dubbo.remoting.exchange.Request=var679, r1=var1523, $r0=var428, $r2=var32, $l0=var3010, $r3=var1534, $r5=var3212, $r4=var3772, $r6=var365, $r7=var2516, $z0=var2671, $r8=var3112, $r9=var2706, $z1=var3434, $r10=var1288, $r11=var3328, $z2=var2376, $r12=var2180, $r13=var2141, $i1=var2439, $r14=var2411, $r17=var2500, java.lang.Object=var551, $r15=var274, $r16=var2175, $r21=var1698, $r18=var2183, $r19=var546, $r20=var3373}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(long)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 10,"<java.lang.StringBuilder: java.lang.StringBuilder append(long)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.remoting.exchange.Request;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Request [id=");	$l0 = r1.<org.apache.dubbo.remoting.exchange.Request: long mId>;	$r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l0);	$r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", version=");	$r4 = r1.<org.apache.dubbo.remoting.exchange.Request: java.lang.String mVersion>;	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", twoWay=");	$z0 = r1.<org.apache.dubbo.remoting.exchange.Request: boolean mTwoWay>;	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>($z0);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", event=");	$z1 = r1.<org.apache.dubbo.remoting.exchange.Request: boolean mEvent>;	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>($z1);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", broken=");	$z2 = r1.<org.apache.dubbo.remoting.exchange.Request: boolean mBroken>;	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>($z2);	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", mPayload=");	$i1 = r1.<org.apache.dubbo.remoting.exchange.Request: int mPayload>;	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i1);	$r17 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", data=");	$r15 = r1.<org.apache.dubbo.remoting.exchange.Request: java.lang.Object mData>;	if $r15 != r1 goto $r16 = r1.<org.apache.dubbo.remoting.exchange.Request: java.lang.Object mData>;	$r16 = r1.<org.apache.dubbo.remoting.exchange.Request: java.lang.Object mData>;	$r21 = staticinvoke <org.apache.dubbo.remoting.exchange.Request: java.lang.String safeToString(java.lang.Object)>($r16);	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r21);	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("]");	$r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.String toString()>();	return $r20
;block_num 3