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

(declare-sort var1826 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun name/596969499 (var1826) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun negated/596969499 (var1826) Bool)
(declare-fun value/596969499 (var1826) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1826 var1826)
(declare-const var1104 var1826) ; Statement: r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression 
(assert (not (= var1104 null-var1826)))
(define-const var1879 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1879)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1879!1 String)
(assert (= var1879!1 ""))
(define-const var3480 String (name/596969499 var1104)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression: java.lang.String name> 
(assert true)
(define-const var3802 String (append/672562846 var1879!1 var3480)) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var1879!2 String)
(assert (= var1879!2 (str.++ var1879!1 var3480)))
(define-const var1943 Bool (negated/596969499 var1104)) ; Statement: $z0 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression: boolean negated> 
 ; Statement: if $z0 == 0 goto $r8 = "=" 
(assert (not (= (ite var1943 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var3946 String "!=") ; Statement: $r8 = "!=" 
 ; Statement: goto [?= $r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8)] 
(assert true) ; Non Conditional
(assert true)
(define-const var2988 String (append/672562846 var3802 var3946)) ; Statement: $r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8) 
(declare-const var3802!1 String)
(assert (= var3802!1 (str.++ var3802 var3946)))
(define-const var1935 String (value/596969499 var1104)) ; Statement: $r4 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression: java.lang.String value> 
(assert true)
(define-const var794 String (append/672562846 var2988 var1935)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var2988!1 String)
(assert (= var2988!1 (str.++ var2988 var1935)))
(assert true)
(define-const var540 String (toString/-2075883882 var794)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r7 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), name/596969499=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), negated/596969499=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression], boolean), value/596969499=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1826=org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression, var1104=r1, var1879=$r0, var3480=$r2, var3802=$r3, var1943=$z0, var3946=$r8, var2988=$r5, var1935=$r4, var794=$r6, var540=$r7}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression=var1826, r1=var1104, $r0=var1879, $r2=var3480, $r3=var3802, $z0=var1943, $r8=var3946, $r5=var2988, $r4=var1935, $r6=var794, $r7=var540}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression: java.lang.String name>;	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$z0 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression: boolean negated>;	if $z0 == 0 goto $r8 = "=";	$r8 = "!=";	goto [?= $r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8)];	$r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8);	$r4 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression: java.lang.String value>;	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	return $r7
;block_num 3