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

(declare-sort var1880 0)
(declare-sort var1480 0)
(declare-sort var419 0)
(declare-sort var2636 0)
(declare-sort var542 0)
(declare-sort var2780 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun acceptable/-1931755004 (var419 var1480) Bool)
(declare-fun cast-from-var1880-to-var419 (var1880) var419)
(declare-fun logger/131801897 (var419) var2636)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var542) String)
(declare-fun cast-from-var1480-to-var542 (var1480) var542)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var2780_info/484404803 (var2780 String) void)
(declare-fun cast-from-var2636-to-var2780 (var2636) var2780)
(declare-const null-var1880 var1880)
(declare-const null-var1480 var1480)
(declare-const var1886 var1880) ; Statement: r0 := @this: org.apache.dubbo.registry.support.FailbackRegistry 
(assert (not (= var1886 null-var1880)))
(declare-const var1382 var1480) ; Statement: r1 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var1382 null-var1480)))
(assert true)
(define-const var1301 Bool (acceptable/-1931755004 (cast-from-var1880-to-var419 var1886) var1382)) ; Statement: $z0 = virtualinvoke r0.<org.apache.dubbo.registry.support.FailbackRegistry: boolean acceptable(org.apache.dubbo.common.URL)>(r1) 
 ; Statement: if $z0 != 0 goto specialinvoke r0.<org.apache.dubbo.registry.support.AbstractRegistry: void register(org.apache.dubbo.common.URL)>(r1) 
(assert (not (not (= (ite var1301 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var1230 var2636 (logger/131801897 (cast-from-var1880-to-var419 var1886))) ; Statement: $r3 = r0.<org.apache.dubbo.registry.support.FailbackRegistry: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var3436 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3436)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3436!1 String)
(assert (= var3436!1 ""))
(assert true)
(define-const var1173 String (append/672562846 var3436!1 "URL ")) ; Statement: $r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("URL ") 
(declare-const var3436!2 String)
(assert (= var3436!2 (str.++ var3436!1 "URL ")))
(assert true)
(define-const var3018 String (append/-1031950772 var1173 (cast-from-var1480-to-var542 var1382))) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1) 
(declare-const var1173!1 String)
(assert (str.prefixof var1173 var1173!1))
(assert true)
(define-const var3100 String (append/672562846 var3018 " will not be registered to Registry. Registry ")) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" will not be registered to Registry. Registry ") 
(declare-const var3018!1 String)
(assert (= var3018!1 (str.++ var3018 " will not be registered to Registry. Registry ")))
(assert true)
(define-const var2694 String (append/-1031950772 var3100 (cast-from-var1480-to-var542 var1382))) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1) 
(declare-const var3100!1 String)
(assert (str.prefixof var3100 var3100!1))
(assert true)
(define-const var1652 String (append/672562846 var2694 " does not accept service of this protocol type.")) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" does not accept service of this protocol type.") 
(declare-const var2694!1 String)
(assert (= var2694!1 (str.++ var2694 " does not accept service of this protocol type.")))
(assert true)
(define-const var3675 String (toString/-2075883882 var1652)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var2780_info/484404803 (cast-from-var2636-to-var2780 var1230) var3675)) ; Statement: interfaceinvoke $r3.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>($r9) 

(declare-const var1230!1 var2636)
(declare-const var3675!1 String)
 ; Statement: return 
(check-sat)
; {acceptable/-1931755004=([org.apache.dubbo.registry.support.AbstractRegistry, org.apache.dubbo.common.URL], boolean), cast-from-var1880-to-var419=([org.apache.dubbo.registry.support.FailbackRegistry], org.apache.dubbo.registry.support.AbstractRegistry), logger/131801897=([org.apache.dubbo.registry.support.AbstractRegistry], org.apache.dubbo.common.logger.ErrorTypeAwareLogger), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var1480-to-var542=([org.apache.dubbo.common.URL], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var2780_info/484404803=([org.apache.dubbo.common.logger.Logger, java.lang.String], void), cast-from-var2636-to-var2780=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger)}
; {var1880=org.apache.dubbo.registry.support.FailbackRegistry, var1886=r0, var1480=org.apache.dubbo.common.URL, var1382=r1, var419=org.apache.dubbo.registry.support.AbstractRegistry, var1301=$z0, var2636=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var1230=$r3, var3436=$r2, var1173=$r4, var542=java.lang.Object, var3018=$r5, var3100=$r6, var2694=$r7, var1652=$r8, var3675=$r9, var2780=org.apache.dubbo.common.logger.Logger}
; {org.apache.dubbo.registry.support.FailbackRegistry=var1880, r0=var1886, org.apache.dubbo.common.URL=var1480, r1=var1382, org.apache.dubbo.registry.support.AbstractRegistry=var419, $z0=var1301, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var2636, $r3=var1230, $r2=var3436, $r4=var1173, java.lang.Object=var542, $r5=var3018, $r6=var3100, $r7=var2694, $r8=var1652, $r9=var3675, org.apache.dubbo.common.logger.Logger=var2780}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.support.FailbackRegistry;	r1 := @parameter0: org.apache.dubbo.common.URL;	$z0 = virtualinvoke r0.<org.apache.dubbo.registry.support.FailbackRegistry: boolean acceptable(org.apache.dubbo.common.URL)>(r1);	if $z0 != 0 goto specialinvoke r0.<org.apache.dubbo.registry.support.AbstractRegistry: void register(org.apache.dubbo.common.URL)>(r1);	$r3 = r0.<org.apache.dubbo.registry.support.FailbackRegistry: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("URL ");	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" will not be registered to Registry. Registry ");	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" does not accept service of this protocol type.");	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r3.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>($r9);	return
;block_num 2