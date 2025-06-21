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

(declare-sort var3386 0)
(declare-sort var3576 0)
(declare-sort var3480 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun canonicalName/331543809 (var3386) String)
(declare-fun codeSource/331543809 (var3386) String)
(declare-fun methods/331543809 (var3386) var3576)
(declare-fun append/-1031950772 (String var3480) String)
(declare-fun cast-from-var3576-to-var3480 (var3576) var3480)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3386 var3386)
(declare-const var1594 var3386) ; Statement: r1 := @this: org.apache.dubbo.metadata.definition.model.ServiceDefinition 
(assert (not (= var1594 null-var3386)))
(define-const var2409 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2409)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2409!1 String)
(assert (= var2409!1 ""))
(assert true)
(define-const var3287 String (append/672562846 var2409!1 "ServiceDefinition [canonicalName=")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ServiceDefinition [canonicalName=") 
(declare-const var2409!2 String)
(assert (= var2409!2 (str.++ var2409!1 "ServiceDefinition [canonicalName=")))
(define-const var2700 String (canonicalName/331543809 var1594)) ; Statement: $r2 = r1.<org.apache.dubbo.metadata.definition.model.ServiceDefinition: java.lang.String canonicalName> 
(assert true)
(define-const var1063 String (append/672562846 var3287 var2700)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var3287!1 String)
(assert (= var3287!1 (str.++ var3287 var2700)))
(assert true)
(define-const var244 String (append/672562846 var1063 ", codeSource=")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", codeSource=") 
(declare-const var1063!1 String)
(assert (= var1063!1 (str.++ var1063 ", codeSource=")))
(define-const var3995 String (codeSource/331543809 var1594)) ; Statement: $r5 = r1.<org.apache.dubbo.metadata.definition.model.ServiceDefinition: java.lang.String codeSource> 
(assert true)
(define-const var3908 String (append/672562846 var244 var3995)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var244!1 String)
(assert (= var244!1 (str.++ var244 var3995)))
(assert true)
(define-const var1476 String (append/672562846 var3908 ", methods=")) ; Statement: $r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", methods=") 
(declare-const var3908!1 String)
(assert (= var3908!1 (str.++ var3908 ", methods=")))
(define-const var381 var3576 (methods/331543809 var1594)) ; Statement: $r8 = r1.<org.apache.dubbo.metadata.definition.model.ServiceDefinition: java.util.List methods> 
(assert true)
(define-const var3871 String (append/-1031950772 var1476 (cast-from-var3576-to-var3480 var381))) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r8) 
(declare-const var1476!1 String)
(assert (str.prefixof var1476 var1476!1))
(assert true)
(define-const var2222 String (append/672562846 var3871 "]")) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("]") 
(declare-const var3871!1 String)
(assert (= var3871!1 (str.++ var3871 "]")))
(assert true)
(define-const var362 String (toString/-2075883882 var2222)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r12 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), canonicalName/331543809=([org.apache.dubbo.metadata.definition.model.ServiceDefinition], java.lang.String), codeSource/331543809=([org.apache.dubbo.metadata.definition.model.ServiceDefinition], java.lang.String), methods/331543809=([org.apache.dubbo.metadata.definition.model.ServiceDefinition], java.util.List), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var3576-to-var3480=([java.util.List], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3386=org.apache.dubbo.metadata.definition.model.ServiceDefinition, var1594=r1, var2409=$r0, var3287=$r3, var2700=$r2, var1063=$r4, var244=$r6, var3995=$r5, var3908=$r7, var1476=$r9, var3576=java.util.List, var381=$r8, var3480=java.lang.Object, var3871=$r10, var2222=$r11, var362=$r12}
; {org.apache.dubbo.metadata.definition.model.ServiceDefinition=var3386, r1=var1594, $r0=var2409, $r3=var3287, $r2=var2700, $r4=var1063, $r6=var244, $r5=var3995, $r7=var3908, $r9=var1476, java.util.List=var3576, $r8=var381, java.lang.Object=var3480, $r10=var3871, $r11=var2222, $r12=var362}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 6,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.metadata.definition.model.ServiceDefinition;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ServiceDefinition [canonicalName=");	$r2 = r1.<org.apache.dubbo.metadata.definition.model.ServiceDefinition: java.lang.String canonicalName>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", codeSource=");	$r5 = r1.<org.apache.dubbo.metadata.definition.model.ServiceDefinition: java.lang.String codeSource>;	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", methods=");	$r8 = r1.<org.apache.dubbo.metadata.definition.model.ServiceDefinition: java.util.List methods>;	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r8);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("]");	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>();	return $r12
;block_num 1