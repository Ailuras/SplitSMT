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

(declare-sort var1186 0)
(declare-sort var3954 0)
(declare-sort var593 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3954_interfaceFromServiceKey/131280368 (String) String)
(declare-fun var3954_versionFromServiceKey/1753360625 (String) String)
(declare-fun var593_isEmpty/-813097145 (String) Bool)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-String String)
(declare-const var2998 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2998 null-String)))
(define-const var1886 String (var3954_interfaceFromServiceKey/131280368 var2998)) ; Statement: r1 = staticinvoke <org.apache.dubbo.common.BaseServiceMetadata: java.lang.String interfaceFromServiceKey(java.lang.String)>(r0) 
(define-const var1329 String (var3954_versionFromServiceKey/1753360625 var2998)) ; Statement: r2 = staticinvoke <org.apache.dubbo.common.BaseServiceMetadata: java.lang.String versionFromServiceKey(java.lang.String)>(r0) 
(define-const var3848 Bool (var593_isEmpty/-813097145 var1329)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto $r3 = new java.lang.StringBuilder 
(assert (= (ite var3848 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1628 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1628)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1628!1 String)
(assert (= var1628!1 ""))
(assert true)
(define-const var1635 String (append/672562846 var1628!1 var1886)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var1628!2 String)
(assert (= var1628!2 (str.++ var1628!1 var1886)))
(assert true)
(define-const var2731 String (append/672562846 var1635 ":")) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(":") 
(declare-const var1635!1 String)
(assert (= var1635!1 (str.++ var1635 ":")))
(assert true)
(define-const var2317 String (append/672562846 var2731 var1329)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2) 
(declare-const var2731!1 String)
(assert (= var2731!1 (str.++ var2731 var1329)))
(assert true)
(define-const var3834 String (toString/-2075883882 var2317)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r7 
(check-sat)
; {var3954_interfaceFromServiceKey/131280368=([java.lang.String], java.lang.String), var3954_versionFromServiceKey/1753360625=([java.lang.String], java.lang.String), var593_isEmpty/-813097145=([java.lang.String], boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2998=r0, var1186=null_type, var3954=org.apache.dubbo.common.BaseServiceMetadata, var1886=r1, var1329=r2, var593=org.apache.dubbo.common.utils.StringUtils, var3848=$z0, var1628=$r3, var1635=$r4, var2731=$r5, var2317=$r6, var3834=$r7}
; {r0=var2998, null_type=var1186, org.apache.dubbo.common.BaseServiceMetadata=var3954, r1=var1886, r2=var1329, org.apache.dubbo.common.utils.StringUtils=var593, $z0=var3848, $r3=var1628, $r4=var1635, $r5=var2731, $r6=var2317, $r7=var3834}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 = staticinvoke <org.apache.dubbo.common.BaseServiceMetadata: java.lang.String interfaceFromServiceKey(java.lang.String)>(r0);	r2 = staticinvoke <org.apache.dubbo.common.BaseServiceMetadata: java.lang.String versionFromServiceKey(java.lang.String)>(r0);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	if $z0 == 0 goto $r3 = new java.lang.StringBuilder;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(":");	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	return $r7
;block_num 2