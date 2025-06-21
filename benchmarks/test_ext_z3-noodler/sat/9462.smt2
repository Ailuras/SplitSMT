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

(declare-sort var1964 0)
(declare-sort var1830 0)
(declare-sort var3388 0)
(declare-sort var3909 0)
(declare-sort var91 0)
(declare-sort var3514 0)
(declare-sort var2712 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun listeners/-775390699 (var1964) var3909)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var3514_get/1088891777 (var3514 var91) var91)
(declare-fun cast-from-var3909-to-var3514 (var3909) var3514)
(declare-fun cast-from-String-to-var91 (String) var91)
(declare-fun cast-from-var91-to-var2712 (var91) var2712)
(declare-const null-var1964 var1964)
(declare-const null-String String)
(declare-const null-var3388 var3388)
(declare-const null-var2712 var2712)
(declare-const var1523 var1964) ; Statement: r0 := @this: org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration 
(assert (not (= var1523 null-var1964)))
(declare-const var2817 String) ; Statement: r4 := @parameter0: java.lang.String 
(assert (not (= var2817 null-String)))
(declare-const var555 String) ; Statement: r3 := @parameter1: java.lang.String 
(assert (not (= var555 null-String)))
(declare-const var720 var3388) ; Statement: r10 := @parameter2: org.apache.dubbo.common.config.configcenter.ConfigurationListener 
(assert (not (= var720 null-var3388)))
(define-const var1186 var3909 (listeners/-775390699 var1523)) ; Statement: $r2 = r0.<org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration: java.util.concurrent.ConcurrentMap listeners> 
(define-const var1799 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1799)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1799!1 String)
(assert (= var1799!1 ""))
(assert true)
(define-const var1510 String (append/672562846 var1799!1 var555)) ; Statement: $r5 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r3) 
(declare-const var1799!2 String)
(assert (= var1799!2 (str.++ var1799!1 var555)))
(assert true)
(define-const var2117 String (append/672562846 var1510 var2817)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4) 
(declare-const var1510!1 String)
(assert (= var1510!1 (str.++ var1510 var2817)))
(assert true)
(define-const var1874 String (toString/-2075883882 var2117)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var2898 var91 (var3514_get/1088891777 (cast-from-var3909-to-var3514 var1186) (cast-from-String-to-var91 var1874))) ; Statement: $r8 = interfaceinvoke $r2.<java.util.concurrent.ConcurrentMap: java.lang.Object get(java.lang.Object)>($r7) 
(define-const var1640 var2712 (cast-from-var91-to-var2712 var2898)) ; Statement: r9 = (org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration$ApolloListener) $r8 
 ; Statement: if r9 == null goto return 
(assert (= var1640 null-var2712)) ; Cond: r9 == null 
 ; Statement: return 
(check-sat)
; {listeners/-775390699=([org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration], java.util.concurrent.ConcurrentMap), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var3514_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-var3909-to-var3514=([java.util.concurrent.ConcurrentMap], java.util.Map), cast-from-String-to-var91=([java.lang.String], java.lang.Object), cast-from-var91-to-var2712=([java.lang.Object], org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration$ApolloListener)}
; {var1964=org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration, var1523=r0, var2817=r4, var1830=null_type, var555=r3, var3388=org.apache.dubbo.common.config.configcenter.ConfigurationListener, var720=r10, var3909=java.util.concurrent.ConcurrentMap, var1186=$r2, var1799=$r1, var1510=$r5, var2117=$r6, var1874=$r7, var91=java.lang.Object, var3514=java.util.Map, var2898=$r8, var2712=org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration$ApolloListener, var1640=r9}
; {org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration=var1964, r0=var1523, r4=var2817, null_type=var1830, r3=var555, org.apache.dubbo.common.config.configcenter.ConfigurationListener=var3388, r10=var720, java.util.concurrent.ConcurrentMap=var3909, $r2=var1186, $r1=var1799, $r5=var1510, $r6=var2117, $r7=var1874, java.lang.Object=var91, java.util.Map=var3514, $r8=var2898, org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration$ApolloListener=var2712, r9=var1640}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration;	r4 := @parameter0: java.lang.String;	r3 := @parameter1: java.lang.String;	r10 := @parameter2: org.apache.dubbo.common.config.configcenter.ConfigurationListener;	$r2 = r0.<org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration: java.util.concurrent.ConcurrentMap listeners>;	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r5 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r3);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	$r8 = interfaceinvoke $r2.<java.util.concurrent.ConcurrentMap: java.lang.Object get(java.lang.Object)>($r7);	r9 = (org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration$ApolloListener) $r8;	if r9 == null goto return;	return
;block_num 2