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

(declare-sort var3160 0)
(declare-sort var1691 0)
(declare-sort var974 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun name/-1627620645 (var3160) String)
(declare-fun parameterTypes/-1627620645 (var3160) (Array Int String))
(declare-fun var1691_toString/-575966009 ((Array Int var974)) String)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var974__ ((Array Int String)) (Array Int var974))
(declare-fun returnType/-1627620645 (var3160) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3160 var3160)
(declare-const var2502 var3160) ; Statement: r1 := @this: org.apache.dubbo.metadata.definition.model.MethodDefinition 
(assert (not (= var2502 null-var3160)))
(define-const var1518 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1518)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1518!1 String)
(assert (= var1518!1 ""))
(assert true)
(define-const var3977 String (append/672562846 var1518!1 "MethodDefinition [name=")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("MethodDefinition [name=") 
(declare-const var1518!2 String)
(assert (= var1518!2 (str.++ var1518!1 "MethodDefinition [name=")))
(define-const var2656 String (name/-1627620645 var2502)) ; Statement: $r2 = r1.<org.apache.dubbo.metadata.definition.model.MethodDefinition: java.lang.String name> 
(assert true)
(define-const var2579 String (append/672562846 var3977 var2656)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var3977!1 String)
(assert (= var3977!1 (str.++ var3977 var2656)))
(assert true)
(define-const var1094 String (append/672562846 var2579 ", parameterTypes=")) ; Statement: $r7 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", parameterTypes=") 
(declare-const var2579!1 String)
(assert (= var2579!1 (str.++ var2579 ", parameterTypes=")))
(define-const var670 (Array Int String) (parameterTypes/-1627620645 var2502)) ; Statement: $r5 = r1.<org.apache.dubbo.metadata.definition.model.MethodDefinition: java.lang.String[] parameterTypes> 
(define-const var3642 String (var1691_toString/-575966009 (cast-from-__Array__Int__String__-to-__Array__Int__var974__ var670))) ; Statement: $r6 = staticinvoke <java.util.Arrays: java.lang.String toString(java.lang.Object[])>($r5) 
(assert true)
(define-const var3996 String (append/672562846 var1094 var3642)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var1094!1 String)
(assert (= var1094!1 (str.++ var1094 var3642)))
(assert true)
(define-const var2034 String (append/672562846 var3996 ", returnType=")) ; Statement: $r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", returnType=") 
(declare-const var3996!1 String)
(assert (= var3996!1 (str.++ var3996 ", returnType=")))
(define-const var538 String (returnType/-1627620645 var2502)) ; Statement: $r9 = r1.<org.apache.dubbo.metadata.definition.model.MethodDefinition: java.lang.String returnType> 
(assert true)
(define-const var3057 String (append/672562846 var2034 var538)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9) 
(declare-const var2034!1 String)
(assert (= var2034!1 (str.++ var2034 var538)))
(assert true)
(define-const var2286 String (append/672562846 var3057 "]")) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("]") 
(declare-const var3057!1 String)
(assert (= var3057!1 (str.++ var3057 "]")))
(assert true)
(define-const var3030 String (toString/-2075883882 var2286)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r13 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), name/-1627620645=([org.apache.dubbo.metadata.definition.model.MethodDefinition], java.lang.String), parameterTypes/-1627620645=([org.apache.dubbo.metadata.definition.model.MethodDefinition], java.lang.String[]), var1691_toString/-575966009=([java.lang.Object[]], java.lang.String), cast-from-__Array__Int__String__-to-__Array__Int__var974__=([java.lang.String[]], java.lang.Object[]), returnType/-1627620645=([org.apache.dubbo.metadata.definition.model.MethodDefinition], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3160=org.apache.dubbo.metadata.definition.model.MethodDefinition, var2502=r1, var1518=$r0, var3977=$r3, var2656=$r2, var2579=$r4, var1094=$r7, var670=$r5, var1691=java.util.Arrays, var974=java.lang.Object, var3642=$r6, var3996=$r8, var2034=$r10, var538=$r9, var3057=$r11, var2286=$r12, var3030=$r13}
; {org.apache.dubbo.metadata.definition.model.MethodDefinition=var3160, r1=var2502, $r0=var1518, $r3=var3977, $r2=var2656, $r4=var2579, $r7=var1094, $r5=var670, java.util.Arrays=var1691, java.lang.Object=var974, $r6=var3642, $r8=var3996, $r10=var2034, $r9=var538, $r11=var3057, $r12=var2286, $r13=var3030}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.util.Arrays: java.lang.String toString(java.lang.Object[])>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 7,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.metadata.definition.model.MethodDefinition;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("MethodDefinition [name=");	$r2 = r1.<org.apache.dubbo.metadata.definition.model.MethodDefinition: java.lang.String name>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r7 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", parameterTypes=");	$r5 = r1.<org.apache.dubbo.metadata.definition.model.MethodDefinition: java.lang.String[] parameterTypes>;	$r6 = staticinvoke <java.util.Arrays: java.lang.String toString(java.lang.Object[])>($r5);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	$r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", returnType=");	$r9 = r1.<org.apache.dubbo.metadata.definition.model.MethodDefinition: java.lang.String returnType>;	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9);	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("]");	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>();	return $r13
;block_num 1