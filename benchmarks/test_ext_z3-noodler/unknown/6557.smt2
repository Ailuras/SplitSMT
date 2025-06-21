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

(declare-sort var624 0)
(declare-sort var3297 0)
(declare-sort var2851 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun type/383558580 (var624) String)
(declare-fun properties/383558580 (var624) var3297)
(declare-fun append/-1031950772 (String var2851) String)
(declare-fun cast-from-var3297-to-var2851 (var3297) var2851)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var624 var624)
(declare-const var3456 var624) ; Statement: r1 := @this: org.apache.dubbo.metadata.definition.model.TypeDefinition 
(assert (not (= var3456 null-var624)))
(define-const var3240 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3240)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3240!1 String)
(assert (= var3240!1 ""))
(assert true)
(define-const var3099 String (append/672562846 var3240!1 "TypeDefinition [type=")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("TypeDefinition [type=") 
(declare-const var3240!2 String)
(assert (= var3240!2 (str.++ var3240!1 "TypeDefinition [type=")))
(define-const var3353 String (type/383558580 var3456)) ; Statement: $r2 = r1.<org.apache.dubbo.metadata.definition.model.TypeDefinition: java.lang.String type> 
(assert true)
(define-const var2888 String (append/672562846 var3099 var3353)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var3099!1 String)
(assert (= var3099!1 (str.++ var3099 var3353)))
(assert true)
(define-const var3566 String (append/672562846 var2888 ", properties=")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", properties=") 
(declare-const var2888!1 String)
(assert (= var2888!1 (str.++ var2888 ", properties=")))
(define-const var1850 var3297 (properties/383558580 var3456)) ; Statement: $r5 = r1.<org.apache.dubbo.metadata.definition.model.TypeDefinition: java.util.Map properties> 
(assert true)
(define-const var201 String (append/-1031950772 var3566 (cast-from-var3297-to-var2851 var1850))) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r5) 
(declare-const var3566!1 String)
(assert (str.prefixof var3566 var3566!1))
(assert true)
(define-const var3776 String (append/672562846 var201 "]")) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("]") 
(declare-const var201!1 String)
(assert (= var201!1 (str.++ var201 "]")))
(assert true)
(define-const var940 String (toString/-2075883882 var3776)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r9 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), type/383558580=([org.apache.dubbo.metadata.definition.model.TypeDefinition], java.lang.String), properties/383558580=([org.apache.dubbo.metadata.definition.model.TypeDefinition], java.util.Map), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var3297-to-var2851=([java.util.Map], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var624=org.apache.dubbo.metadata.definition.model.TypeDefinition, var3456=r1, var3240=$r0, var3099=$r3, var3353=$r2, var2888=$r4, var3566=$r6, var3297=java.util.Map, var1850=$r5, var2851=java.lang.Object, var201=$r7, var3776=$r8, var940=$r9}
; {org.apache.dubbo.metadata.definition.model.TypeDefinition=var624, r1=var3456, $r0=var3240, $r3=var3099, $r2=var3353, $r4=var2888, $r6=var3566, java.util.Map=var3297, $r5=var1850, java.lang.Object=var2851, $r7=var201, $r8=var3776, $r9=var940}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.metadata.definition.model.TypeDefinition;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("TypeDefinition [type=");	$r2 = r1.<org.apache.dubbo.metadata.definition.model.TypeDefinition: java.lang.String type>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", properties=");	$r5 = r1.<org.apache.dubbo.metadata.definition.model.TypeDefinition: java.util.Map properties>;	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r5);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("]");	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	return $r9
;block_num 1