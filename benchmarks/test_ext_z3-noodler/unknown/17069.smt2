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

(declare-sort var3360 0)
(declare-sort var3255 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun mId/-417699929 (var3360) Int)
(declare-fun append/-901862667 (String Int) String)
(declare-fun mVersion/-417699929 (var3360) String)
(declare-fun mStatus/-417699929 (var3360) Int)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(declare-fun mEvent/-417699929 (var3360) Bool)
(declare-fun append/-388390247 (String Bool) String)
(declare-fun mErrorMsg/-417699929 (var3360) String)
(declare-fun mResult/-417699929 (var3360) var3255)
(declare-fun cast-from-var3360-to-var3255 (var3360) var3255)
(declare-fun append/-1031950772 (String var3255) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3360 var3360)
(declare-const var3444 var3360) ; Statement: r1 := @this: org.apache.dubbo.remoting.exchange.Response 
(assert (not (= var3444 null-var3360)))
(define-const var1744 String String-init) ; Statement: $r20 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1744)) ; Statement: specialinvoke $r20.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1744!1 String)
(assert (= var1744!1 ""))
(assert true)
(define-const var903 String (append/672562846 var1744!1 "Response [id=")) ; Statement: $r2 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Response [id=") 
(declare-const var1744!2 String)
(assert (= var1744!2 (str.++ var1744!1 "Response [id=")))
(define-const var854 Int (mId/-417699929 var3444)) ; Statement: $l0 = r1.<org.apache.dubbo.remoting.exchange.Response: long mId> 
(assert true)
(define-const var3363 String (append/-901862667 var903 var854)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l0) 
(declare-const var903!1 String)
(assert (str.prefixof var903 var903!1))
(assert true)
(define-const var3120 String (append/672562846 var3363 ", version=")) ; Statement: $r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", version=") 
(declare-const var3363!1 String)
(assert (= var3363!1 (str.++ var3363 ", version=")))
(define-const var3021 String (mVersion/-417699929 var3444)) ; Statement: $r4 = r1.<org.apache.dubbo.remoting.exchange.Response: java.lang.String mVersion> 
(assert true)
(define-const var642 String (append/672562846 var3120 var3021)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var3120!1 String)
(assert (= var3120!1 (str.++ var3120 var3021)))
(assert true)
(define-const var1008 String (append/672562846 var642 ", status=")) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", status=") 
(declare-const var642!1 String)
(assert (= var642!1 (str.++ var642 ", status=")))
(define-const var1343 Int (mStatus/-417699929 var3444)) ; Statement: $b1 = r1.<org.apache.dubbo.remoting.exchange.Response: byte mStatus> 
(define-const var1702 Int (cast-from-Int-to-Int var1343)) ; Statement: $i2 = (int) $b1 
(assert true)
(define-const var18 String (append/-1001720160 var1008 var1702)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i2) 
(declare-const var1008!1 String)
(assert (str.prefixof var1008 var1008!1))
(assert true)
(define-const var637 String (append/672562846 var18 ", event=")) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", event=") 
(declare-const var18!1 String)
(assert (= var18!1 (str.++ var18 ", event=")))
(define-const var496 Bool (mEvent/-417699929 var3444)) ; Statement: $z0 = r1.<org.apache.dubbo.remoting.exchange.Response: boolean mEvent> 
(assert true)
(define-const var2013 String (append/-388390247 var637 var496)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>($z0) 
(declare-const var637!1 String)
(assert (str.prefixof var637 var637!1))
(assert true)
(define-const var3309 String (append/672562846 var2013 ", error=")) ; Statement: $r12 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", error=") 
(declare-const var2013!1 String)
(assert (= var2013!1 (str.++ var2013 ", error=")))
(define-const var544 String (mErrorMsg/-417699929 var3444)) ; Statement: $r11 = r1.<org.apache.dubbo.remoting.exchange.Response: java.lang.String mErrorMsg> 
(assert true)
(define-const var3443 String (append/672562846 var3309 var544)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r11) 
(declare-const var3309!1 String)
(assert (= var3309!1 (str.++ var3309 var544)))
(assert true)
(define-const var2421 String (append/672562846 var3443 ", result=")) ; Statement: $r15 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", result=") 
(declare-const var3443!1 String)
(assert (= var3443!1 (str.++ var3443 ", result=")))
(define-const var1081 var3255 (mResult/-417699929 var3444)) ; Statement: $r14 = r1.<org.apache.dubbo.remoting.exchange.Response: java.lang.Object mResult> 
 ; Statement: if $r14 != r1 goto $r19 = r1.<org.apache.dubbo.remoting.exchange.Response: java.lang.Object mResult> 
(assert (not (= var1081 (cast-from-var3360-to-var3255 var3444)))) ; Cond: $r14 != r1 
(define-const var3650 var3255 (mResult/-417699929 var3444)) ; Statement: $r19 = r1.<org.apache.dubbo.remoting.exchange.Response: java.lang.Object mResult> 
(assert true) ; Non Conditional
(assert true)
(define-const var2074 String (append/-1031950772 var2421 var3650)) ; Statement: $r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r19) 
(declare-const var2421!1 String)
(assert (str.prefixof var2421 var2421!1))
(assert true)
(define-const var2669 String (append/672562846 var2074 "]")) ; Statement: $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("]") 
(declare-const var2074!1 String)
(assert (= var2074!1 (str.++ var2074 "]")))
(assert true)
(define-const var2192 String (toString/-2075883882 var2669)) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r18 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), mId/-417699929=([org.apache.dubbo.remoting.exchange.Response], long), append/-901862667=([java.lang.StringBuilder, long], java.lang.StringBuilder), mVersion/-417699929=([org.apache.dubbo.remoting.exchange.Response], java.lang.String), mStatus/-417699929=([org.apache.dubbo.remoting.exchange.Response], byte), cast-from-Int-to-Int=([byte], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), mEvent/-417699929=([org.apache.dubbo.remoting.exchange.Response], boolean), append/-388390247=([java.lang.StringBuilder, boolean], java.lang.StringBuilder), mErrorMsg/-417699929=([org.apache.dubbo.remoting.exchange.Response], java.lang.String), mResult/-417699929=([org.apache.dubbo.remoting.exchange.Response], java.lang.Object), cast-from-var3360-to-var3255=([org.apache.dubbo.remoting.exchange.Response], java.lang.Object), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3360=org.apache.dubbo.remoting.exchange.Response, var3444=r1, var1744=$r20, var903=$r2, var854=$l0, var3363=$r3, var3120=$r5, var3021=$r4, var642=$r6, var1008=$r7, var1343=$b1, var1702=$i2, var18=$r8, var637=$r9, var496=$z0, var2013=$r10, var3309=$r12, var544=$r11, var3443=$r13, var2421=$r15, var3255=java.lang.Object, var1081=$r14, var3650=$r19, var2074=$r16, var2669=$r17, var2192=$r18}
; {org.apache.dubbo.remoting.exchange.Response=var3360, r1=var3444, $r20=var1744, $r2=var903, $l0=var854, $r3=var3363, $r5=var3120, $r4=var3021, $r6=var642, $r7=var1008, $b1=var1343, $i2=var1702, $r8=var18, $r9=var637, $z0=var496, $r10=var2013, $r12=var3309, $r11=var544, $r13=var3443, $r15=var2421, java.lang.Object=var3255, $r14=var1081, $r19=var3650, $r16=var2074, $r17=var2669, $r18=var2192}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(long)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 9,"<java.lang.StringBuilder: java.lang.StringBuilder append(long)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.remoting.exchange.Response;	$r20 = new java.lang.StringBuilder;	specialinvoke $r20.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Response [id=");	$l0 = r1.<org.apache.dubbo.remoting.exchange.Response: long mId>;	$r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l0);	$r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", version=");	$r4 = r1.<org.apache.dubbo.remoting.exchange.Response: java.lang.String mVersion>;	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", status=");	$b1 = r1.<org.apache.dubbo.remoting.exchange.Response: byte mStatus>;	$i2 = (int) $b1;	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i2);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", event=");	$z0 = r1.<org.apache.dubbo.remoting.exchange.Response: boolean mEvent>;	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>($z0);	$r12 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", error=");	$r11 = r1.<org.apache.dubbo.remoting.exchange.Response: java.lang.String mErrorMsg>;	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r11);	$r15 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", result=");	$r14 = r1.<org.apache.dubbo.remoting.exchange.Response: java.lang.Object mResult>;	if $r14 != r1 goto $r19 = r1.<org.apache.dubbo.remoting.exchange.Response: java.lang.Object mResult>;	$r19 = r1.<org.apache.dubbo.remoting.exchange.Response: java.lang.Object mResult>;	$r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r19);	$r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("]");	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.String toString()>();	return $r18
;block_num 3