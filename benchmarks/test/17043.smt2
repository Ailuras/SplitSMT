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

(declare-sort var1375 0)
(declare-sort var1825 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun mId/-417699929 (var1375) Int)
(declare-fun append/-901862667 (String Int) String)
(declare-fun mVersion/-417699929 (var1375) String)
(declare-fun mStatus/-417699929 (var1375) Int)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(declare-fun mEvent/-417699929 (var1375) Bool)
(declare-fun append/-388390247 (String Bool) String)
(declare-fun mErrorMsg/-417699929 (var1375) String)
(declare-fun mResult/-417699929 (var1375) var1825)
(declare-fun cast-from-var1375-to-var1825 (var1375) var1825)
(declare-fun cast-from-String-to-var1825 (String) var1825)
(declare-fun append/-1031950772 (String var1825) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1375 var1375)
(declare-const var91 var1375) ; Statement: r1 := @this: org.apache.dubbo.remoting.exchange.Response 
(assert (not (= var91 null-var1375)))
(define-const var2997 String String-init) ; Statement: $r20 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2997)) ; Statement: specialinvoke $r20.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2997!1 String)
(assert (= var2997!1 ""))
(assert true)
(define-const var1899 String (append/672562846 var2997!1 "Response [id=")) ; Statement: $r2 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Response [id=") 
(declare-const var2997!2 String)
(assert (= var2997!2 (str.++ var2997!1 "Response [id=")))
(define-const var522 Int (mId/-417699929 var91)) ; Statement: $l0 = r1.<org.apache.dubbo.remoting.exchange.Response: long mId> 
(assert true)
(define-const var3622 String (append/-901862667 var1899 var522)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l0) 
(declare-const var1899!1 String)
(assert (str.prefixof var1899 var1899!1))
(assert true)
(define-const var562 String (append/672562846 var3622 ", version=")) ; Statement: $r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", version=") 
(declare-const var3622!1 String)
(assert (= var3622!1 (str.++ var3622 ", version=")))
(define-const var263 String (mVersion/-417699929 var91)) ; Statement: $r4 = r1.<org.apache.dubbo.remoting.exchange.Response: java.lang.String mVersion> 
(assert true)
(define-const var2995 String (append/672562846 var562 var263)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var562!1 String)
(assert (= var562!1 (str.++ var562 var263)))
(assert true)
(define-const var1752 String (append/672562846 var2995 ", status=")) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", status=") 
(declare-const var2995!1 String)
(assert (= var2995!1 (str.++ var2995 ", status=")))
(define-const var2820 Int (mStatus/-417699929 var91)) ; Statement: $b1 = r1.<org.apache.dubbo.remoting.exchange.Response: byte mStatus> 
(define-const var15 Int (cast-from-Int-to-Int var2820)) ; Statement: $i2 = (int) $b1 
(assert true)
(define-const var3015 String (append/-1001720160 var1752 var15)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i2) 
(declare-const var1752!1 String)
(assert (str.prefixof var1752 var1752!1))
(assert true)
(define-const var3303 String (append/672562846 var3015 ", event=")) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", event=") 
(declare-const var3015!1 String)
(assert (= var3015!1 (str.++ var3015 ", event=")))
(define-const var3256 Bool (mEvent/-417699929 var91)) ; Statement: $z0 = r1.<org.apache.dubbo.remoting.exchange.Response: boolean mEvent> 
(assert true)
(define-const var2599 String (append/-388390247 var3303 var3256)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>($z0) 
(declare-const var3303!1 String)
(assert (str.prefixof var3303 var3303!1))
(assert true)
(define-const var1409 String (append/672562846 var2599 ", error=")) ; Statement: $r12 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", error=") 
(declare-const var2599!1 String)
(assert (= var2599!1 (str.++ var2599 ", error=")))
(define-const var3610 String (mErrorMsg/-417699929 var91)) ; Statement: $r11 = r1.<org.apache.dubbo.remoting.exchange.Response: java.lang.String mErrorMsg> 
(assert true)
(define-const var2716 String (append/672562846 var1409 var3610)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r11) 
(declare-const var1409!1 String)
(assert (= var1409!1 (str.++ var1409 var3610)))
(assert true)
(define-const var2387 String (append/672562846 var2716 ", result=")) ; Statement: $r15 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", result=") 
(declare-const var2716!1 String)
(assert (= var2716!1 (str.++ var2716 ", result=")))
(define-const var3748 var1825 (mResult/-417699929 var91)) ; Statement: $r14 = r1.<org.apache.dubbo.remoting.exchange.Response: java.lang.Object mResult> 
 ; Statement: if $r14 != r1 goto $r19 = r1.<org.apache.dubbo.remoting.exchange.Response: java.lang.Object mResult> 
(assert (not (not (= var3748 (cast-from-var1375-to-var1825 var91))))) ; Negate: Cond: $r14 != r1  
(define-const var822 var1825 (cast-from-String-to-var1825 "this")) ; Statement: $r19 = "this" 
 ; Statement: goto [?= $r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r19)] 
(assert true) ; Non Conditional
(assert true)
(define-const var304 String (append/-1031950772 var2387 var822)) ; Statement: $r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r19) 
(declare-const var2387!1 String)
(assert (str.prefixof var2387 var2387!1))
(assert true)
(define-const var2631 String (append/672562846 var304 "]")) ; Statement: $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("]") 
(declare-const var304!1 String)
(assert (= var304!1 (str.++ var304 "]")))
(assert true)
(define-const var3979 String (toString/-2075883882 var2631)) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r18 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), mId/-417699929=([org.apache.dubbo.remoting.exchange.Response], long), append/-901862667=([java.lang.StringBuilder, long], java.lang.StringBuilder), mVersion/-417699929=([org.apache.dubbo.remoting.exchange.Response], java.lang.String), mStatus/-417699929=([org.apache.dubbo.remoting.exchange.Response], byte), cast-from-Int-to-Int=([byte], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), mEvent/-417699929=([org.apache.dubbo.remoting.exchange.Response], boolean), append/-388390247=([java.lang.StringBuilder, boolean], java.lang.StringBuilder), mErrorMsg/-417699929=([org.apache.dubbo.remoting.exchange.Response], java.lang.String), mResult/-417699929=([org.apache.dubbo.remoting.exchange.Response], java.lang.Object), cast-from-var1375-to-var1825=([org.apache.dubbo.remoting.exchange.Response], java.lang.Object), cast-from-String-to-var1825=([java.lang.String], java.lang.Object), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1375=org.apache.dubbo.remoting.exchange.Response, var91=r1, var2997=$r20, var1899=$r2, var522=$l0, var3622=$r3, var562=$r5, var263=$r4, var2995=$r6, var1752=$r7, var2820=$b1, var15=$i2, var3015=$r8, var3303=$r9, var3256=$z0, var2599=$r10, var1409=$r12, var3610=$r11, var2716=$r13, var2387=$r15, var1825=java.lang.Object, var3748=$r14, var822=$r19, var304=$r16, var2631=$r17, var3979=$r18}
; {org.apache.dubbo.remoting.exchange.Response=var1375, r1=var91, $r20=var2997, $r2=var1899, $l0=var522, $r3=var3622, $r5=var562, $r4=var263, $r6=var2995, $r7=var1752, $b1=var2820, $i2=var15, $r8=var3015, $r9=var3303, $z0=var3256, $r10=var2599, $r12=var1409, $r11=var3610, $r13=var2716, $r15=var2387, java.lang.Object=var1825, $r14=var3748, $r19=var822, $r16=var304, $r17=var2631, $r18=var3979}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(long)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 9,"<java.lang.StringBuilder: java.lang.StringBuilder append(long)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.remoting.exchange.Response;	$r20 = new java.lang.StringBuilder;	specialinvoke $r20.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Response [id=");	$l0 = r1.<org.apache.dubbo.remoting.exchange.Response: long mId>;	$r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l0);	$r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", version=");	$r4 = r1.<org.apache.dubbo.remoting.exchange.Response: java.lang.String mVersion>;	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", status=");	$b1 = r1.<org.apache.dubbo.remoting.exchange.Response: byte mStatus>;	$i2 = (int) $b1;	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i2);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", event=");	$z0 = r1.<org.apache.dubbo.remoting.exchange.Response: boolean mEvent>;	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>($z0);	$r12 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", error=");	$r11 = r1.<org.apache.dubbo.remoting.exchange.Response: java.lang.String mErrorMsg>;	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r11);	$r15 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", result=");	$r14 = r1.<org.apache.dubbo.remoting.exchange.Response: java.lang.Object mResult>;	if $r14 != r1 goto $r19 = r1.<org.apache.dubbo.remoting.exchange.Response: java.lang.Object mResult>;	$r19 = "this";	goto [?= $r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r19)];	$r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r19);	$r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("]");	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.String toString()>();	return $r18
;block_num 3