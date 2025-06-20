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

(declare-sort var531 0)
(declare-sort var3478 0)
(declare-sort var3956 0)
(declare-sort var702 0)
(declare-sort var2123 0)
(declare-sort var3688 0)
(declare-sort var944 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun unregister/-1677681220 (var3956 var3478) void)
(declare-fun cast-from-var531-to-var3956 (var531) var3956)
(declare-fun removeFailedRegistered/-1879744 (var531 var3478) void)
(declare-fun removeFailedUnregistered/-884115687 (var531 var3478) void)
(declare-fun var2123-init () var2123)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var3688) String)
(declare-fun cast-from-var3478-to-var3688 (var3478) var3688)
(declare-fun getUrl/866469067 (var3956) var3478)
(declare-fun getAddress/-2093578336 (var3478) String)
(declare-fun getMessage/849299655 (var944) String)
(declare-fun cast-from-var702-to-var944 (var702) var944)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1447874194 (var2123 String var944) void)
(declare-const null-var531 var531)
(declare-const null-var3478 var3478)
(declare-const null-var702 var702)
(declare-const var1113 var531) ; Statement: r0 := @this: org.apache.dubbo.registry.support.FailbackRegistry 
(assert (not (= var1113 null-var531)))
(declare-const var3502 var3478) ; Statement: r1 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var3502 null-var3478)))
(assert true)
;(assert (unregister/-1677681220 (cast-from-var531-to-var3956 var1113) var3502)) ; Statement: specialinvoke r0.<org.apache.dubbo.registry.support.AbstractRegistry: void unregister(org.apache.dubbo.common.URL)>(r1) 

(declare-const var1113!1 var531)
(declare-const var3502!1 var3478)
(assert true)
;(assert (removeFailedRegistered/-1879744 var1113!1 var3502!1)) ; Statement: specialinvoke r0.<org.apache.dubbo.registry.support.FailbackRegistry: void removeFailedRegistered(org.apache.dubbo.common.URL)>(r1) 

(declare-const var1113!2 var531)
(declare-const var3502!2 var3478)
(assert true)
;(assert (removeFailedUnregistered/-884115687 var1113!2 var3502!2)) ; Statement: specialinvoke r0.<org.apache.dubbo.registry.support.FailbackRegistry: void removeFailedUnregistered(org.apache.dubbo.common.URL)>(r1) 

(declare-const var1113!3 var531)
(declare-const var3502!3 var3478)
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var2743 var702) ; Statement: $r2 := @caughtexception 
(assert (not (= var2743 null-var702)))
(define-const var1862 Bool false) ; Statement: $z0 = $r2 instanceof org.apache.dubbo.registry.support.SkipFailbackWrapperException 
 ; Statement: if $z0 != 0 goto return 
(assert (not (not (= (ite var1862 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var1934 var2123 var2123-init) ; Statement: $r3 = new java.lang.IllegalStateException 
(define-const var358 String String-init) ; Statement: $r4 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var358)) ; Statement: specialinvoke $r4.<java.lang.StringBuilder: void <init>()>() 
(declare-const var358!1 String)
(assert (= var358!1 ""))
(assert true)
(define-const var3041 String (append/672562846 var358!1 "Failed to unregister(re-export) ")) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to unregister(re-export) ") 
(declare-const var358!2 String)
(assert (= var358!2 (str.++ var358!1 "Failed to unregister(re-export) ")))
(assert true)
(define-const var3827 String (append/-1031950772 var3041 (cast-from-var3478-to-var3688 var3502!3))) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1) 
(declare-const var3041!1 String)
(assert (str.prefixof var3041 var3041!1))
(assert true)
(define-const var1156 String (append/672562846 var3827 " to registry ")) ; Statement: $r9 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" to registry ") 
(declare-const var3827!1 String)
(assert (= var3827!1 (str.++ var3827 " to registry ")))
(assert true)
(define-const var283 var3478 (getUrl/866469067 (cast-from-var531-to-var3956 var1113!3))) ; Statement: $r7 = virtualinvoke r0.<org.apache.dubbo.registry.support.FailbackRegistry: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var3330 String (getAddress/-2093578336 var283)) ; Statement: $r8 = virtualinvoke $r7.<org.apache.dubbo.common.URL: java.lang.String getAddress()>() 
(assert true)
(define-const var244 String (append/672562846 var1156 var3330)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8) 
(declare-const var1156!1 String)
(assert (= var1156!1 (str.++ var1156 var3330)))
(assert true)
(define-const var3591 String (append/672562846 var244 ", cause: ")) ; Statement: $r12 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ") 
(declare-const var244!1 String)
(assert (= var244!1 (str.++ var244 ", cause: ")))
(assert true)
(define-const var3915 String (getMessage/849299655 (cast-from-var702-to-var944 var2743))) ; Statement: $r11 = virtualinvoke $r2.<java.lang.Exception: java.lang.String getMessage()>() 
(assert true)
(define-const var80 String (append/672562846 var3591 var3915)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r11) 
(declare-const var3591!1 String)
(assert (= var3591!1 (str.++ var3591 var3915)))
(assert true)
(define-const var982 String (toString/-2075883882 var80)) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1447874194 var1934 var982 (cast-from-var702-to-var944 var2743))) ; Statement: specialinvoke $r3.<java.lang.IllegalStateException: void <init>(java.lang.String,java.lang.Throwable)>($r14, $r2) 

(declare-const var1934!1 var2123)
(declare-const var982!1 String)
(declare-const var2743!1 var702)
 ; Statement: throw $r3 
(check-sat)
; {unregister/-1677681220=([org.apache.dubbo.registry.support.AbstractRegistry, org.apache.dubbo.common.URL], void), cast-from-var531-to-var3956=([org.apache.dubbo.registry.support.FailbackRegistry], org.apache.dubbo.registry.support.AbstractRegistry), removeFailedRegistered/-1879744=([org.apache.dubbo.registry.support.FailbackRegistry, org.apache.dubbo.common.URL], void), removeFailedUnregistered/-884115687=([org.apache.dubbo.registry.support.FailbackRegistry, org.apache.dubbo.common.URL], void), var2123-init=([], java.lang.IllegalStateException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var3478-to-var3688=([org.apache.dubbo.common.URL], java.lang.Object), getUrl/866469067=([org.apache.dubbo.registry.support.AbstractRegistry], org.apache.dubbo.common.URL), getAddress/-2093578336=([org.apache.dubbo.common.URL], java.lang.String), getMessage/849299655=([java.lang.Throwable], java.lang.String), cast-from-var702-to-var944=([java.lang.Exception], java.lang.Throwable), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1447874194=([java.lang.IllegalStateException, java.lang.String, java.lang.Throwable], void)}
; {var531=org.apache.dubbo.registry.support.FailbackRegistry, var1113=r0, var3478=org.apache.dubbo.common.URL, var3502=r1, var3956=org.apache.dubbo.registry.support.AbstractRegistry, var702=java.lang.Exception, var2743=$r2, var1862=$z0, var2123=java.lang.IllegalStateException, var1934=$r3, var358=$r4, var3041=$r5, var3688=java.lang.Object, var3827=$r6, var1156=$r9, var283=$r7, var3330=$r8, var244=$r10, var3591=$r12, var944=java.lang.Throwable, var3915=$r11, var80=$r13, var982=$r14}
; {org.apache.dubbo.registry.support.FailbackRegistry=var531, r0=var1113, org.apache.dubbo.common.URL=var3478, r1=var3502, org.apache.dubbo.registry.support.AbstractRegistry=var3956, java.lang.Exception=var702, $r2=var2743, $z0=var1862, java.lang.IllegalStateException=var2123, $r3=var1934, $r4=var358, $r5=var3041, java.lang.Object=var3688, $r6=var3827, $r9=var1156, $r7=var283, $r8=var3330, $r10=var244, $r12=var3591, java.lang.Throwable=var944, $r11=var3915, $r13=var80, $r14=var982}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 5,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.support.FailbackRegistry;	r1 := @parameter0: org.apache.dubbo.common.URL;	specialinvoke r0.<org.apache.dubbo.registry.support.AbstractRegistry: void unregister(org.apache.dubbo.common.URL)>(r1);	specialinvoke r0.<org.apache.dubbo.registry.support.FailbackRegistry: void removeFailedRegistered(org.apache.dubbo.common.URL)>(r1);	specialinvoke r0.<org.apache.dubbo.registry.support.FailbackRegistry: void removeFailedUnregistered(org.apache.dubbo.common.URL)>(r1);	$r2 := @caughtexception;	$z0 = $r2 instanceof org.apache.dubbo.registry.support.SkipFailbackWrapperException;	if $z0 != 0 goto return;	$r3 = new java.lang.IllegalStateException;	$r4 = new java.lang.StringBuilder;	specialinvoke $r4.<java.lang.StringBuilder: void <init>()>();	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to unregister(re-export) ");	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1);	$r9 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" to registry ");	$r7 = virtualinvoke r0.<org.apache.dubbo.registry.support.FailbackRegistry: org.apache.dubbo.common.URL getUrl()>();	$r8 = virtualinvoke $r7.<org.apache.dubbo.common.URL: java.lang.String getAddress()>();	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8);	$r12 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ");	$r11 = virtualinvoke $r2.<java.lang.Exception: java.lang.String getMessage()>();	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r11);	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r3.<java.lang.IllegalStateException: void <init>(java.lang.String,java.lang.Throwable)>($r14, $r2);	throw $r3
;block_num 3