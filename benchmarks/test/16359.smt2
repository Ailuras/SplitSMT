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

(declare-sort var3896 0)
(declare-sort var2884 0)
(declare-sort var1003 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun serviceName/-1063266783 (var3896) String)
(declare-fun append/-1166366385 (String Int) String)
(declare-fun host/-1063266783 (var3896) String)
(declare-fun port/-1063266783 (var3896) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(declare-fun enabled/-1063266783 (var3896) Bool)
(declare-fun append/-388390247 (String Bool) String)
(declare-fun healthy/-1063266783 (var3896) Bool)
(declare-fun metadata/-1063266783 (var3896) var2884)
(declare-fun append/-1031950772 (String var1003) String)
(declare-fun cast-from-var2884-to-var1003 (var2884) var1003)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3896 var3896)
(declare-const var3547 var3896) ; Statement: r1 := @this: org.apache.dubbo.registry.client.DefaultServiceInstance 
(assert (not (= var3547 null-var3896)))
(define-const var1078 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1078)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1078!1 String)
(assert (= var1078!1 ""))
(assert true)
(define-const var289 String (append/672562846 var1078!1 "DefaultServiceInstance{serviceName=\u0027")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("DefaultServiceInstance{serviceName=\'") 
(declare-const var1078!2 String)
(assert (= var1078!2 (str.++ var1078!1 "DefaultServiceInstance{serviceName=\u0027")))
(define-const var163 String (serviceName/-1063266783 var3547)) ; Statement: $r2 = r1.<org.apache.dubbo.registry.client.DefaultServiceInstance: java.lang.String serviceName> 
(assert true)
(define-const var1492 String (append/672562846 var289 var163)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var289!1 String)
(assert (= var289!1 (str.++ var289 var163)))
(assert true)
(define-const var181 String (append/-1166366385 var1492 39)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39) 
(declare-const var1492!1 String)
(assert (str.prefixof var1492 var1492!1))
(assert true)
(define-const var3604 String (append/672562846 var181 ", host=\u0027")) ; Statement: $r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", host=\'") 
(declare-const var181!1 String)
(assert (= var181!1 (str.++ var181 ", host=\u0027")))
(define-const var60 String (host/-1063266783 var3547)) ; Statement: $r6 = r1.<org.apache.dubbo.registry.client.DefaultServiceInstance: java.lang.String host> 
(assert true)
(define-const var2191 String (append/672562846 var3604 var60)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var3604!1 String)
(assert (= var3604!1 (str.++ var3604 var60)))
(assert true)
(define-const var1395 String (append/-1166366385 var2191 39)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39) 
(declare-const var2191!1 String)
(assert (str.prefixof var2191 var2191!1))
(assert true)
(define-const var3402 String (append/672562846 var1395 ", port=")) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", port=") 
(declare-const var1395!1 String)
(assert (= var1395!1 (str.++ var1395 ", port=")))
(define-const var2584 Int (port/-1063266783 var3547)) ; Statement: $i0 = r1.<org.apache.dubbo.registry.client.DefaultServiceInstance: int port> 
(assert true)
(define-const var3801 String (append/-1001720160 var3402 var2584)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0) 
(declare-const var3402!1 String)
(assert (str.prefixof var3402 var3402!1))
(assert true)
(define-const var1961 String (append/672562846 var3801 ", enabled=")) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", enabled=") 
(declare-const var3801!1 String)
(assert (= var3801!1 (str.++ var3801 ", enabled=")))
(define-const var3523 Bool (enabled/-1063266783 var3547)) ; Statement: $z0 = r1.<org.apache.dubbo.registry.client.DefaultServiceInstance: boolean enabled> 
(assert true)
(define-const var1098 String (append/-388390247 var1961 var3523)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>($z0) 
(declare-const var1961!1 String)
(assert (str.prefixof var1961 var1961!1))
(assert true)
(define-const var2771 String (append/672562846 var1098 ", healthy=")) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", healthy=") 
(declare-const var1098!1 String)
(assert (= var1098!1 (str.++ var1098 ", healthy=")))
(define-const var1785 Bool (healthy/-1063266783 var3547)) ; Statement: $z1 = r1.<org.apache.dubbo.registry.client.DefaultServiceInstance: boolean healthy> 
(assert true)
(define-const var3319 String (append/-388390247 var2771 var1785)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>($z1) 
(declare-const var2771!1 String)
(assert (str.prefixof var2771 var2771!1))
(assert true)
(define-const var1075 String (append/672562846 var3319 ", metadata=")) ; Statement: $r17 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", metadata=") 
(declare-const var3319!1 String)
(assert (= var3319!1 (str.++ var3319 ", metadata=")))
(define-const var1901 var2884 (metadata/-1063266783 var3547)) ; Statement: $r16 = r1.<org.apache.dubbo.registry.client.DefaultServiceInstance: java.util.Map metadata> 
(assert true)
(define-const var2369 String (append/-1031950772 var1075 (cast-from-var2884-to-var1003 var1901))) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r16) 
(declare-const var1075!1 String)
(assert (str.prefixof var1075 var1075!1))
(assert true)
(define-const var2222 String (append/-1166366385 var2369 125)) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var2369!1 String)
(assert (str.prefixof var2369 var2369!1))
(assert true)
(define-const var3060 String (toString/-2075883882 var2222)) ; Statement: $r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r20 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), serviceName/-1063266783=([org.apache.dubbo.registry.client.DefaultServiceInstance], java.lang.String), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), host/-1063266783=([org.apache.dubbo.registry.client.DefaultServiceInstance], java.lang.String), port/-1063266783=([org.apache.dubbo.registry.client.DefaultServiceInstance], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), enabled/-1063266783=([org.apache.dubbo.registry.client.DefaultServiceInstance], boolean), append/-388390247=([java.lang.StringBuilder, boolean], java.lang.StringBuilder), healthy/-1063266783=([org.apache.dubbo.registry.client.DefaultServiceInstance], boolean), metadata/-1063266783=([org.apache.dubbo.registry.client.DefaultServiceInstance], java.util.Map), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var2884-to-var1003=([java.util.Map], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3896=org.apache.dubbo.registry.client.DefaultServiceInstance, var3547=r1, var1078=$r0, var289=$r3, var163=$r2, var1492=$r4, var181=$r5, var3604=$r7, var60=$r6, var2191=$r8, var1395=$r9, var3402=$r10, var2584=$i0, var3801=$r11, var1961=$r12, var3523=$z0, var1098=$r13, var2771=$r14, var1785=$z1, var3319=$r15, var1075=$r17, var2884=java.util.Map, var1901=$r16, var1003=java.lang.Object, var2369=$r18, var2222=$r19, var3060=$r20}
; {org.apache.dubbo.registry.client.DefaultServiceInstance=var3896, r1=var3547, $r0=var1078, $r3=var289, $r2=var163, $r4=var1492, $r5=var181, $r7=var3604, $r6=var60, $r8=var2191, $r9=var1395, $r10=var3402, $i0=var2584, $r11=var3801, $r12=var1961, $z0=var3523, $r13=var1098, $r14=var2771, $z1=var1785, $r15=var3319, $r17=var1075, java.util.Map=var2884, $r16=var1901, java.lang.Object=var1003, $r18=var2369, $r19=var2222, $r20=var3060}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 8,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.registry.client.DefaultServiceInstance;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("DefaultServiceInstance{serviceName=\'");	$r2 = r1.<org.apache.dubbo.registry.client.DefaultServiceInstance: java.lang.String serviceName>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39);	$r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", host=\'");	$r6 = r1.<org.apache.dubbo.registry.client.DefaultServiceInstance: java.lang.String host>;	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", port=");	$i0 = r1.<org.apache.dubbo.registry.client.DefaultServiceInstance: int port>;	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0);	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", enabled=");	$z0 = r1.<org.apache.dubbo.registry.client.DefaultServiceInstance: boolean enabled>;	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>($z0);	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", healthy=");	$z1 = r1.<org.apache.dubbo.registry.client.DefaultServiceInstance: boolean healthy>;	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>($z1);	$r17 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", metadata=");	$r16 = r1.<org.apache.dubbo.registry.client.DefaultServiceInstance: java.util.Map metadata>;	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r16);	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.String toString()>();	return $r20
;block_num 1