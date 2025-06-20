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

(declare-sort var2250 0)
(declare-sort var363 0)
(declare-sort var2232 0)
(declare-sort var2864 0)
(declare-sort var2361 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var2864) String)
(declare-fun cast-from-var363-to-var2864 (var363) var2864)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var2232_info/484404803 (var2232 String) void)
(declare-fun getParameters/-392598339 (var363) var2361)
(declare-fun addParameters/1869535242 (var363 var2361) var363)
(declare-const null-var2250 var2250)
(declare-const null-var363 var363)
(declare-const var2250-logger var2232)
(declare-const var1805 var2250) ; Statement: r11 := @this: org.apache.dubbo.rpc.cluster.configurator.override.OverrideConfigurator 
(assert (not (= var1805 null-var2250)))
(declare-const var3125 var363) ; Statement: r2 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var3125 null-var363)))
(declare-const var1414 var363) ; Statement: r5 := @parameter1: org.apache.dubbo.common.URL 
(assert (not (= var1414 null-var363)))
(define-const var419 var2232 var2250-logger) ; Statement: $r1 = <org.apache.dubbo.rpc.cluster.configurator.override.OverrideConfigurator: org.apache.dubbo.common.logger.Logger logger> 
(define-const var1881 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1881)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1881!1 String)
(assert (= var1881!1 ""))
(assert true)
(define-const var2546 String (append/672562846 var1881!1 "Start overriding url ")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Start overriding url ") 
(declare-const var1881!2 String)
(assert (= var1881!2 (str.++ var1881!1 "Start overriding url ")))
(assert true)
(define-const var113 String (append/-1031950772 var2546 (cast-from-var363-to-var2864 var3125))) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r2) 
(declare-const var2546!1 String)
(assert (str.prefixof var2546 var2546!1))
(assert true)
(define-const var934 String (append/672562846 var113 " with override url ")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" with override url ") 
(declare-const var113!1 String)
(assert (= var113!1 (str.++ var113 " with override url ")))
(assert true)
(define-const var1326 String (append/-1031950772 var934 (cast-from-var363-to-var2864 var1414))) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r5) 
(declare-const var934!1 String)
(assert (str.prefixof var934 var934!1))
(assert true)
(define-const var1820 String (toString/-2075883882 var1326)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var2232_info/484404803 var419 var1820)) ; Statement: interfaceinvoke $r1.<org.apache.dubbo.common.logger.Logger: void info(java.lang.String)>($r8) 

(declare-const var419!1 var2232)
(declare-const var1820!1 String)
(assert true)
(define-const var3019 var2361 (getParameters/-392598339 var1414)) ; Statement: $r9 = virtualinvoke r5.<org.apache.dubbo.common.URL: java.util.Map getParameters()>() 
(assert true)
(define-const var1220 var363 (addParameters/1869535242 var3125 var3019)) ; Statement: $r10 = virtualinvoke r2.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameters(java.util.Map)>($r9) 
 ; Statement: return $r10 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var363-to-var2864=([org.apache.dubbo.common.URL], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var2232_info/484404803=([org.apache.dubbo.common.logger.Logger, java.lang.String], void), getParameters/-392598339=([org.apache.dubbo.common.URL], java.util.Map), addParameters/1869535242=([org.apache.dubbo.common.URL, java.util.Map], org.apache.dubbo.common.URL)}
; {var2250=org.apache.dubbo.rpc.cluster.configurator.override.OverrideConfigurator, var1805=r11, var363=org.apache.dubbo.common.URL, var3125=r2, var1414=r5, var2232=org.apache.dubbo.common.logger.Logger, var419=$r1, var1881=$r0, var2546=$r3, var2864=java.lang.Object, var113=$r4, var934=$r6, var1326=$r7, var1820=$r8, var2361=java.util.Map, var3019=$r9, var1220=$r10}
; {org.apache.dubbo.rpc.cluster.configurator.override.OverrideConfigurator=var2250, r11=var1805, org.apache.dubbo.common.URL=var363, r2=var3125, r5=var1414, org.apache.dubbo.common.logger.Logger=var2232, $r1=var419, $r0=var1881, $r3=var2546, java.lang.Object=var2864, $r4=var113, $r6=var934, $r7=var1326, $r8=var1820, java.util.Map=var2361, $r9=var3019, $r10=var1220}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r11 := @this: org.apache.dubbo.rpc.cluster.configurator.override.OverrideConfigurator;	r2 := @parameter0: org.apache.dubbo.common.URL;	r5 := @parameter1: org.apache.dubbo.common.URL;	$r1 = <org.apache.dubbo.rpc.cluster.configurator.override.OverrideConfigurator: org.apache.dubbo.common.logger.Logger logger>;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Start overriding url ");	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r2);	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" with override url ");	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r5);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r1.<org.apache.dubbo.common.logger.Logger: void info(java.lang.String)>($r8);	$r9 = virtualinvoke r5.<org.apache.dubbo.common.URL: java.util.Map getParameters()>();	$r10 = virtualinvoke r2.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameters(java.util.Map)>($r9);	return $r10
;block_num 1