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

(declare-sort var2615 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun name/596969499 (var2615) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun negated/596969499 (var2615) Bool)
(declare-fun value/596969499 (var2615) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2615 var2615)
(declare-const var2216 var2615) ; Statement: r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression 
(assert (not (= var2216 null-var2615)))
(define-const var1484 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1484)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1484!1 String)
(assert (= var1484!1 ""))
(define-const var2577 String (name/596969499 var2216)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression: java.lang.String name> 
(assert true)
(define-const var878 String (append/672562846 var1484!1 var2577)) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var1484!2 String)
(assert (= var1484!2 (str.++ var1484!1 var2577)))
(define-const var3533 Bool (negated/596969499 var2216)) ; Statement: $z0 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression: boolean negated> 
 ; Statement: if $z0 == 0 goto $r8 = "=" 
(assert (= (ite var3533 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3556 String "=") ; Statement: $r8 = "=" 
(assert true) ; Non Conditional
(assert true)
(define-const var2280 String (append/672562846 var878 var3556)) ; Statement: $r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8) 
(declare-const var878!1 String)
(assert (= var878!1 (str.++ var878 var3556)))
(define-const var1925 String (value/596969499 var2216)) ; Statement: $r4 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression: java.lang.String value> 
(assert true)
(define-const var431 String (append/672562846 var2280 var1925)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var2280!1 String)
(assert (= var2280!1 (str.++ var2280 var1925)))
(assert true)
(define-const var1958 String (toString/-2075883882 var431)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r7 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), name/596969499=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), negated/596969499=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression], boolean), value/596969499=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2615=org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression, var2216=r1, var1484=$r0, var2577=$r2, var878=$r3, var3533=$z0, var3556=$r8, var2280=$r5, var1925=$r4, var431=$r6, var1958=$r7}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression=var2615, r1=var2216, $r0=var1484, $r2=var2577, $r3=var878, $z0=var3533, $r8=var3556, $r5=var2280, $r4=var1925, $r6=var431, $r7=var1958}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression: java.lang.String name>;	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$z0 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression: boolean negated>;	if $z0 == 0 goto $r8 = "=";	$r8 = "=";	$r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8);	$r4 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression: java.lang.String value>;	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	return $r7
;block_num 3