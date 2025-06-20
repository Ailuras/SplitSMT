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

(declare-sort var1367 0)
(declare-sort var1264 0)
(declare-sort var1210 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getCompatibleColonSeparatedKey/279123051 (var1264) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1367 var1367)
(declare-const null-var1264 var1264)
(declare-const null-String String)
(declare-const var1367-SERVICE_NAME_SEPARATOR String)
(declare-const var3162 var1367) ; Statement: r9 := @this: org.apache.dubbo.registry.nacos.NacosRegistry 
(assert (not (= var3162 null-var1367)))
(declare-const var1411 var1264) ; Statement: r4 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var1411 null-var1264)))
(declare-const var3335 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var3335 null-String)))
(define-const var256 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var256)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var256!1 String)
(assert (= var256!1 ""))
(assert true)
(define-const var1678 String (append/672562846 var256!1 var3335)) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var256!2 String)
(assert (= var256!2 (str.++ var256!1 var3335)))
(define-const var3415 String var1367-SERVICE_NAME_SEPARATOR) ; Statement: $r2 = <org.apache.dubbo.registry.nacos.NacosRegistry: java.lang.String SERVICE_NAME_SEPARATOR> 
(assert true)
(define-const var1478 String (append/672562846 var1678 var3415)) ; Statement: $r6 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var1678!1 String)
(assert (= var1678!1 (str.++ var1678 var3415)))
(assert true)
(define-const var2252 String (getCompatibleColonSeparatedKey/279123051 var1411)) ; Statement: $r5 = virtualinvoke r4.<org.apache.dubbo.common.URL: java.lang.String getCompatibleColonSeparatedKey()>() 
(assert true)
(define-const var2708 String (append/672562846 var1478 var2252)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var1478!1 String)
(assert (= var1478!1 (str.++ var1478 var2252)))
(assert true)
(define-const var1295 String (toString/-2075883882 var2708)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r8 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getCompatibleColonSeparatedKey/279123051=([org.apache.dubbo.common.URL], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1367=org.apache.dubbo.registry.nacos.NacosRegistry, var3162=r9, var1264=org.apache.dubbo.common.URL, var1411=r4, var3335=r1, var1210=null_type, var256=$r0, var1678=$r3, var3415=$r2, var1478=$r6, var2252=$r5, var2708=$r7, var1295=$r8}
; {org.apache.dubbo.registry.nacos.NacosRegistry=var1367, r9=var3162, org.apache.dubbo.common.URL=var1264, r4=var1411, r1=var3335, null_type=var1210, $r0=var256, $r3=var1678, $r2=var3415, $r6=var1478, $r5=var2252, $r7=var2708, $r8=var1295}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r9 := @this: org.apache.dubbo.registry.nacos.NacosRegistry;	r4 := @parameter0: org.apache.dubbo.common.URL;	r1 := @parameter1: java.lang.String;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	$r2 = <org.apache.dubbo.registry.nacos.NacosRegistry: java.lang.String SERVICE_NAME_SEPARATOR>;	$r6 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r5 = virtualinvoke r4.<org.apache.dubbo.common.URL: java.lang.String getCompatibleColonSeparatedKey()>();	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	return $r8
;block_num 1