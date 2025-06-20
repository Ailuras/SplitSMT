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

(declare-sort var2769 0)
(declare-sort var1749 0)
(declare-sort var347 0)
(declare-sort var302 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var302_hasSubProperties/974152141 (var1749 String) Bool)
(declare-const null-var2769 var2769)
(declare-const null-var1749 var1749)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var515 var2769) ; Statement: r8 := @this: org.apache.dubbo.config.AbstractInterfaceConfig 
(assert (not (= var515 null-var2769)))
(declare-const var3145 var1749) ; Statement: r7 := @parameter0: java.util.Map 
(assert (not (= var3145 null-var1749)))
(declare-const var2488 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var2488 null-String)))
(declare-const var266 Int) ; Statement: i0 := @parameter2: int 
(assert (not (= var266 null-Int)))
(define-const var1530 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1530)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1530!1 String)
(assert (= var1530!1 ""))
(assert true)
(define-const var1328 String (append/672562846 var1530!1 var2488)) ; Statement: $r2 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var1530!2 String)
(assert (= var1530!2 (str.++ var1530!1 var2488)))
(assert true)
(define-const var427 String (append/672562846 var1328 ".")) ; Statement: $r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".") 
(declare-const var1328!1 String)
(assert (= var1328!1 (str.++ var1328 ".")))
(assert true)
(define-const var1329 String (append/-1001720160 var427 var266)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0) 
(declare-const var427!1 String)
(assert (str.prefixof var427 var427!1))
(assert true)
(define-const var270 String (append/672562846 var1329 ".")) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".") 
(declare-const var1329!1 String)
(assert (= var1329!1 (str.++ var1329 ".")))
(assert true)
(define-const var3942 String (toString/-2075883882 var270)) ; Statement: r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var507 Bool (var302_hasSubProperties/974152141 var3145 var3942)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.config.ConfigurationUtils: boolean hasSubProperties(java.util.Map,java.lang.String)>(r7, r6) 
 ; Statement: return $z0 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var302_hasSubProperties/974152141=([java.util.Map, java.lang.String], boolean)}
; {var2769=org.apache.dubbo.config.AbstractInterfaceConfig, var515=r8, var1749=java.util.Map, var3145=r7, var2488=r1, var347=null_type, var266=i0, var1530=$r0, var1328=$r2, var427=$r3, var1329=$r4, var270=$r5, var3942=r6, var302=org.apache.dubbo.common.config.ConfigurationUtils, var507=$z0}
; {org.apache.dubbo.config.AbstractInterfaceConfig=var2769, r8=var515, java.util.Map=var1749, r7=var3145, r1=var2488, null_type=var347, i0=var266, $r0=var1530, $r2=var1328, $r3=var427, $r4=var1329, $r5=var270, r6=var3942, org.apache.dubbo.common.config.ConfigurationUtils=var302, $z0=var507}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r8 := @this: org.apache.dubbo.config.AbstractInterfaceConfig;	r7 := @parameter0: java.util.Map;	r1 := @parameter1: java.lang.String;	i0 := @parameter2: int;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	$r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".");	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".");	r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	$z0 = staticinvoke <org.apache.dubbo.common.config.ConfigurationUtils: boolean hasSubProperties(java.util.Map,java.lang.String)>(r7, r6);	return $z0
;block_num 1