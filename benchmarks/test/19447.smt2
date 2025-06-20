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

(declare-sort var1296 0)
(declare-sort var1352 0)
(declare-sort var537 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1352_interfaceFromServiceKey/131280368 (String) String)
(declare-fun var1352_versionFromServiceKey/1753360625 (String) String)
(declare-fun var537_isEmpty/-813097145 (String) Bool)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-String String)
(declare-const var1652 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1652 null-String)))
(define-const var1326 String (var1352_interfaceFromServiceKey/131280368 var1652)) ; Statement: r1 = staticinvoke <org.apache.dubbo.common.BaseServiceMetadata: java.lang.String interfaceFromServiceKey(java.lang.String)>(r0) 
(define-const var866 String (var1352_versionFromServiceKey/1753360625 var1652)) ; Statement: r2 = staticinvoke <org.apache.dubbo.common.BaseServiceMetadata: java.lang.String versionFromServiceKey(java.lang.String)>(r0) 
(define-const var2809 Bool (var537_isEmpty/-813097145 var866)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto $r3 = new java.lang.StringBuilder 
(assert (= (ite var2809 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1806 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1806)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1806!1 String)
(assert (= var1806!1 ""))
(assert true)
(define-const var1623 String (append/672562846 var1806!1 var1326)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var1806!2 String)
(assert (= var1806!2 (str.++ var1806!1 var1326)))
(assert true)
(define-const var165 String (append/672562846 var1623 ":")) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(":") 
(declare-const var1623!1 String)
(assert (= var1623!1 (str.++ var1623 ":")))
(assert true)
(define-const var3991 String (append/672562846 var165 var866)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2) 
(declare-const var165!1 String)
(assert (= var165!1 (str.++ var165 var866)))
(assert true)
(define-const var3454 String (toString/-2075883882 var3991)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r7 
(check-sat)
; {var1352_interfaceFromServiceKey/131280368=([java.lang.String], java.lang.String), var1352_versionFromServiceKey/1753360625=([java.lang.String], java.lang.String), var537_isEmpty/-813097145=([java.lang.String], boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1652=r0, var1296=null_type, var1352=org.apache.dubbo.common.BaseServiceMetadata, var1326=r1, var866=r2, var537=org.apache.dubbo.common.utils.StringUtils, var2809=$z0, var1806=$r3, var1623=$r4, var165=$r5, var3991=$r6, var3454=$r7}
; {r0=var1652, null_type=var1296, org.apache.dubbo.common.BaseServiceMetadata=var1352, r1=var1326, r2=var866, org.apache.dubbo.common.utils.StringUtils=var537, $z0=var2809, $r3=var1806, $r4=var1623, $r5=var165, $r6=var3991, $r7=var3454}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 = staticinvoke <org.apache.dubbo.common.BaseServiceMetadata: java.lang.String interfaceFromServiceKey(java.lang.String)>(r0);	r2 = staticinvoke <org.apache.dubbo.common.BaseServiceMetadata: java.lang.String versionFromServiceKey(java.lang.String)>(r0);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	if $z0 == 0 goto $r3 = new java.lang.StringBuilder;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(":");	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	return $r7
;block_num 2