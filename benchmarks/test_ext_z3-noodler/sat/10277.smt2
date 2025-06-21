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

(declare-sort var940 0)
(declare-sort var1156 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun arr-String-init () (Array Int String))
(declare-fun protocol/-1743171095 (var940) String)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun revision/-1743171095 (var940) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun getIdentifierKey/90740075 (var1156 (Array Int String)) String)
(declare-fun cast-from-var940-to-var1156 (var940) var1156)
(declare-const null-var940 var940)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var1394 var940) ; Statement: r0 := @this: org.apache.dubbo.metadata.report.identifier.ServiceMetadataIdentifier 
(assert (not (= var1394 null-var940)))
(define-const var3541 (Array Int String) arr-String-init) ; Statement: $r1 = newarray (java.lang.String)[2] 
(define-const var692 String (protocol/-1743171095 var1394)) ; Statement: $r2 = r0.<org.apache.dubbo.metadata.report.identifier.ServiceMetadataIdentifier: java.lang.String protocol> 
(declare-const var3541!1 (Array Int String))
(assert (not (= var3541!1 null-__Array__Int__String__)))
(assert (= (select var3541!1 0) var692)) ; Statement: $r1[0] = $r2 
(define-const var1095 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1095)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1095!1 String)
(assert (= var1095!1 ""))
(assert true)
(define-const var415 String (append/672562846 var1095!1 "revision")) ; Statement: $r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("revision") 
(declare-const var1095!2 String)
(assert (= var1095!2 (str.++ var1095!1 "revision")))
(define-const var3439 String (revision/-1743171095 var1394)) ; Statement: $r4 = r0.<org.apache.dubbo.metadata.report.identifier.ServiceMetadataIdentifier: java.lang.String revision> 
(assert true)
(define-const var1309 String (append/672562846 var415 var3439)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var415!1 String)
(assert (= var415!1 (str.++ var415 var3439)))
(assert true)
(define-const var3864 String (toString/-2075883882 var1309)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
(declare-const var3541!2 (Array Int String))
(assert (not (= var3541!2 null-__Array__Int__String__)))
(assert (= (select var3541!2 1) var3864)) ; Statement: $r1[1] = $r7 
(assert true)
(define-const var1133 String (getIdentifierKey/90740075 (cast-from-var940-to-var1156 var1394) var3541!2)) ; Statement: $r8 = specialinvoke r0.<org.apache.dubbo.metadata.report.identifier.BaseServiceMetadataIdentifier: java.lang.String getIdentifierKey(java.lang.String[])>($r1) 
 ; Statement: return $r8 
(check-sat)
; {arr-String-init=([], java.lang.String[]), protocol/-1743171095=([org.apache.dubbo.metadata.report.identifier.ServiceMetadataIdentifier], java.lang.String), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), revision/-1743171095=([org.apache.dubbo.metadata.report.identifier.ServiceMetadataIdentifier], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), getIdentifierKey/90740075=([org.apache.dubbo.metadata.report.identifier.BaseServiceMetadataIdentifier, java.lang.String[]], java.lang.String), cast-from-var940-to-var1156=([org.apache.dubbo.metadata.report.identifier.ServiceMetadataIdentifier], org.apache.dubbo.metadata.report.identifier.BaseServiceMetadataIdentifier)}
; {var940=org.apache.dubbo.metadata.report.identifier.ServiceMetadataIdentifier, var1394=r0, var3541=$r1, var692=$r2, var1095=$r3, var415=$r5, var3439=$r4, var1309=$r6, var3864=$r7, var1156=org.apache.dubbo.metadata.report.identifier.BaseServiceMetadataIdentifier, var1133=$r8}
; {org.apache.dubbo.metadata.report.identifier.ServiceMetadataIdentifier=var940, r0=var1394, $r1=var3541, $r2=var692, $r3=var1095, $r5=var415, $r4=var3439, $r6=var1309, $r7=var3864, org.apache.dubbo.metadata.report.identifier.BaseServiceMetadataIdentifier=var1156, $r8=var1133}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.metadata.report.identifier.ServiceMetadataIdentifier;	$r1 = newarray (java.lang.String)[2];	$r2 = r0.<org.apache.dubbo.metadata.report.identifier.ServiceMetadataIdentifier: java.lang.String protocol>;	$r1[0] = $r2;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("revision");	$r4 = r0.<org.apache.dubbo.metadata.report.identifier.ServiceMetadataIdentifier: java.lang.String revision>;	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	$r1[1] = $r7;	$r8 = specialinvoke r0.<org.apache.dubbo.metadata.report.identifier.BaseServiceMetadataIdentifier: java.lang.String getIdentifierKey(java.lang.String[])>($r1);	return $r8
;block_num 1