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

(declare-sort var488 0)
(declare-sort var3739 0)
(declare-sort var2080 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun arr-String-init () (Array Int String))
(declare-fun protocol/-1743171095 (var488) String)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun revision/-1743171095 (var488) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun getUniqueKey/-740590327 (var2080 var3739 (Array Int String)) String)
(declare-fun cast-from-var488-to-var2080 (var488) var2080)
(declare-const null-var488 var488)
(declare-const null-var3739 var3739)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var93 var488) ; Statement: r0 := @this: org.apache.dubbo.metadata.report.identifier.ServiceMetadataIdentifier 
(assert (not (= var93 null-var488)))
(declare-const var2603 var3739) ; Statement: r1 := @parameter0: org.apache.dubbo.metadata.report.identifier.KeyTypeEnum 
(assert (not (= var2603 null-var3739)))
(define-const var1555 (Array Int String) arr-String-init) ; Statement: $r2 = newarray (java.lang.String)[2] 
(define-const var2750 String (protocol/-1743171095 var93)) ; Statement: $r3 = r0.<org.apache.dubbo.metadata.report.identifier.ServiceMetadataIdentifier: java.lang.String protocol> 
(declare-const var1555!1 (Array Int String))
(assert (not (= var1555!1 null-__Array__Int__String__)))
(assert (= (select var1555!1 0) var2750)) ; Statement: $r2[0] = $r3 
(define-const var411 String String-init) ; Statement: $r4 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var411)) ; Statement: specialinvoke $r4.<java.lang.StringBuilder: void <init>()>() 
(declare-const var411!1 String)
(assert (= var411!1 ""))
(assert true)
(define-const var1160 String (append/672562846 var411!1 "revision")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("revision") 
(declare-const var411!2 String)
(assert (= var411!2 (str.++ var411!1 "revision")))
(define-const var3594 String (revision/-1743171095 var93)) ; Statement: $r5 = r0.<org.apache.dubbo.metadata.report.identifier.ServiceMetadataIdentifier: java.lang.String revision> 
(assert true)
(define-const var3916 String (append/672562846 var1160 var3594)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var1160!1 String)
(assert (= var1160!1 (str.++ var1160 var3594)))
(assert true)
(define-const var108 String (toString/-2075883882 var3916)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
(declare-const var1555!2 (Array Int String))
(assert (not (= var1555!2 null-__Array__Int__String__)))
(assert (= (select var1555!2 1) var108)) ; Statement: $r2[1] = $r8 
(assert true)
(define-const var29 String (getUniqueKey/-740590327 (cast-from-var488-to-var2080 var93) var2603 var1555!2)) ; Statement: $r9 = specialinvoke r0.<org.apache.dubbo.metadata.report.identifier.BaseServiceMetadataIdentifier: java.lang.String getUniqueKey(org.apache.dubbo.metadata.report.identifier.KeyTypeEnum,java.lang.String[])>(r1, $r2) 
 ; Statement: return $r9 
(check-sat)
; {arr-String-init=([], java.lang.String[]), protocol/-1743171095=([org.apache.dubbo.metadata.report.identifier.ServiceMetadataIdentifier], java.lang.String), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), revision/-1743171095=([org.apache.dubbo.metadata.report.identifier.ServiceMetadataIdentifier], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), getUniqueKey/-740590327=([org.apache.dubbo.metadata.report.identifier.BaseServiceMetadataIdentifier, org.apache.dubbo.metadata.report.identifier.KeyTypeEnum, java.lang.String[]], java.lang.String), cast-from-var488-to-var2080=([org.apache.dubbo.metadata.report.identifier.ServiceMetadataIdentifier], org.apache.dubbo.metadata.report.identifier.BaseServiceMetadataIdentifier)}
; {var488=org.apache.dubbo.metadata.report.identifier.ServiceMetadataIdentifier, var93=r0, var3739=org.apache.dubbo.metadata.report.identifier.KeyTypeEnum, var2603=r1, var1555=$r2, var2750=$r3, var411=$r4, var1160=$r6, var3594=$r5, var3916=$r7, var108=$r8, var2080=org.apache.dubbo.metadata.report.identifier.BaseServiceMetadataIdentifier, var29=$r9}
; {org.apache.dubbo.metadata.report.identifier.ServiceMetadataIdentifier=var488, r0=var93, org.apache.dubbo.metadata.report.identifier.KeyTypeEnum=var3739, r1=var2603, $r2=var1555, $r3=var2750, $r4=var411, $r6=var1160, $r5=var3594, $r7=var3916, $r8=var108, org.apache.dubbo.metadata.report.identifier.BaseServiceMetadataIdentifier=var2080, $r9=var29}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.metadata.report.identifier.ServiceMetadataIdentifier;	r1 := @parameter0: org.apache.dubbo.metadata.report.identifier.KeyTypeEnum;	$r2 = newarray (java.lang.String)[2];	$r3 = r0.<org.apache.dubbo.metadata.report.identifier.ServiceMetadataIdentifier: java.lang.String protocol>;	$r2[0] = $r3;	$r4 = new java.lang.StringBuilder;	specialinvoke $r4.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("revision");	$r5 = r0.<org.apache.dubbo.metadata.report.identifier.ServiceMetadataIdentifier: java.lang.String revision>;	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	$r2[1] = $r8;	$r9 = specialinvoke r0.<org.apache.dubbo.metadata.report.identifier.BaseServiceMetadataIdentifier: java.lang.String getUniqueKey(org.apache.dubbo.metadata.report.identifier.KeyTypeEnum,java.lang.String[])>(r1, $r2);	return $r9
;block_num 1