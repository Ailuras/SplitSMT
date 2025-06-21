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

(declare-sort var3205 0)
(declare-sort var605 0)
(declare-sort var3007 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getClass/1258963082 (var605) ClassObject)
(declare-fun cast-from-var3205-to-var605 (var3205) var605)
(declare-fun getSimpleName/-390194377 (ClassObject) String)
(define-fun replace/2138489945 ((s String) (old String) (new String)) String (str.replace_all s old new))
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getInternalId/804343127 (var3205) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun getModelNamePath/1300149810 (var3205) String)
(declare-fun var3007_hasText/853333513 (String) Bool)
(declare-const null-var3205 var3205)
(declare-const var3635 var3205) ; Statement: r0 := @this: org.apache.dubbo.rpc.model.ScopeModel 
(assert (not (= var3635 null-var3205)))
(assert true)
(define-const var40 ClassObject (getClass/1258963082 (cast-from-var3205-to-var605 var3635))) ; Statement: $r1 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>() 
(assert true)
(define-const var3039 String (getSimpleName/-390194377 var40)) ; Statement: $r2 = virtualinvoke $r1.<java.lang.Class: java.lang.String getSimpleName()>() 
(assert true)
(define-const var326 String (replace/2138489945 var3039 (cast-from-String-to-String "Model") (cast-from-String-to-String ""))) ; Statement: r3 = virtualinvoke $r2.<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>("Model", "") 
(define-const var330 String String-init) ; Statement: $r4 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var330)) ; Statement: specialinvoke $r4.<java.lang.StringBuilder: void <init>()>() 
(declare-const var330!1 String)
(assert (= var330!1 ""))
(assert true)
(define-const var1479 String (append/672562846 var330!1 "Dubbo ")) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Dubbo ") 
(declare-const var330!2 String)
(assert (= var330!2 (str.++ var330!1 "Dubbo ")))
(assert true)
(define-const var2219 String (append/672562846 var1479 var326)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r3) 
(declare-const var1479!1 String)
(assert (= var1479!1 (str.++ var1479 var326)))
(assert true)
(define-const var7 String (append/672562846 var2219 "[")) ; Statement: $r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[") 
(declare-const var2219!1 String)
(assert (= var2219!1 (str.++ var2219 "[")))
(assert true)
(define-const var3511 String (getInternalId/804343127 var3635)) ; Statement: $r7 = virtualinvoke r0.<org.apache.dubbo.rpc.model.ScopeModel: java.lang.String getInternalId()>() 
(assert true)
(define-const var2267 String (append/672562846 var7 var3511)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7) 
(declare-const var7!1 String)
(assert (= var7!1 (str.++ var7 var3511)))
(assert true)
(define-const var64 String (append/672562846 var2267 "]")) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("]") 
(declare-const var2267!1 String)
(assert (= var2267!1 (str.++ var2267 "]")))
(assert true)
(define-const var78 String (toString/-2075883882 var64)) ; Statement: r17 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
(define-const var81 String (getModelNamePath/1300149810 var3635)) ; Statement: r11 = specialinvoke r0.<org.apache.dubbo.rpc.model.ScopeModel: java.lang.String getModelNamePath()>() 
(define-const var985 Bool (var3007_hasText/853333513 (cast-from-String-to-String var81))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>(r11) 
 ; Statement: if $z0 == 0 goto return r17 
(assert (= (ite var985 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return r17 
(check-sat)
; {getClass/1258963082=([java.lang.Object], java.lang.Class), cast-from-var3205-to-var605=([org.apache.dubbo.rpc.model.ScopeModel], java.lang.Object), getSimpleName/-390194377=([java.lang.Class], java.lang.String), replace/2138489945=([java.lang.String, java.lang.CharSequence, java.lang.CharSequence], java.lang.String), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getInternalId/804343127=([org.apache.dubbo.rpc.model.ScopeModel], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), getModelNamePath/1300149810=([org.apache.dubbo.rpc.model.ScopeModel], java.lang.String), var3007_hasText/853333513=([java.lang.CharSequence], boolean)}
; {var3205=org.apache.dubbo.rpc.model.ScopeModel, var3635=r0, var605=java.lang.Object, var40=$r1, var3039=$r2, var326=r3, var330=$r4, var1479=$r5, var2219=$r6, var7=$r8, var3511=$r7, var2267=$r9, var64=$r10, var78=r17, var81=r11, var3007=org.apache.dubbo.common.utils.StringUtils, var985=$z0}
; {org.apache.dubbo.rpc.model.ScopeModel=var3205, r0=var3635, java.lang.Object=var605, $r1=var40, $r2=var3039, r3=var326, $r4=var330, $r5=var1479, $r6=var2219, $r8=var7, $r7=var3511, $r9=var2267, $r10=var64, r17=var78, r11=var81, org.apache.dubbo.common.utils.StringUtils=var3007, $z0=var985}
;seq <java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>
;cnt {"<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 5,"<java.lang.StringBuilder: java.lang.String toString()>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.model.ScopeModel;	$r1 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>();	$r2 = virtualinvoke $r1.<java.lang.Class: java.lang.String getSimpleName()>();	r3 = virtualinvoke $r2.<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>("Model", "");	$r4 = new java.lang.StringBuilder;	specialinvoke $r4.<java.lang.StringBuilder: void <init>()>();	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Dubbo ");	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r3);	$r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[");	$r7 = virtualinvoke r0.<org.apache.dubbo.rpc.model.ScopeModel: java.lang.String getInternalId()>();	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("]");	r17 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>();	r11 = specialinvoke r0.<org.apache.dubbo.rpc.model.ScopeModel: java.lang.String getModelNamePath()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>(r11);	if $z0 == 0 goto return r17;	return r17
;block_num 2