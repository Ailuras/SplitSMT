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

(declare-sort var164 0)
(declare-sort var752 0)
(declare-sort var2644 0)
(declare-sort var3876 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun description/195094363 (var164) String)
(declare-fun arr-var2644-init () (Array Int var2644))
(declare-fun code/195094363 (var164) var3876)
(declare-fun cast-from-var3876-to-var2644 (var3876) var2644)
(declare-fun cast-from-String-to-var2644 (String) var2644)
(declare-fun String_format/1339386452 (String (Array Int var2644)) String)
(declare-const null-var164 var164)
(declare-const null-String String)
(declare-const null-__Array__Int__var2644__ (Array Int var2644))
(declare-const var1724 var164) ; Statement: r0 := @this: org.apache.dubbo.rpc.TriRpcStatus 
(assert (not (= var1724 null-var164)))
(define-const var2087 String (description/195094363 var1724)) ; Statement: $r1 = r0.<org.apache.dubbo.rpc.TriRpcStatus: java.lang.String description> 
 ; Statement: if $r1 == null goto $r2 = r0.<org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.TriRpcStatus$Code code> 
(assert (not (= var2087 null-String))) ; Negate: Cond: $r1 == null  
(define-const var1773 (Array Int var2644) arr-var2644-init) ; Statement: $r4 = newarray (java.lang.Object)[2] 
(define-const var532 var3876 (code/195094363 var1724)) ; Statement: $r5 = r0.<org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.TriRpcStatus$Code code> 
(declare-const var1773!1 (Array Int var2644))
(assert (not (= var1773!1 null-__Array__Int__var2644__)))
(assert (= (select var1773!1 0) (cast-from-var3876-to-var2644 var532))) ; Statement: $r4[0] = $r5 
(define-const var3101 String (description/195094363 var1724)) ; Statement: $r6 = r0.<org.apache.dubbo.rpc.TriRpcStatus: java.lang.String description> 
(declare-const var1773!2 (Array Int var2644))
(assert (not (= var1773!2 null-__Array__Int__var2644__)))
(assert (= (select var1773!2 1) (cast-from-String-to-var2644 var3101))) ; Statement: $r4[1] = $r6 
(define-const var1307 String (String_format/1339386452 "%s : %s" var1773!2)) ; Statement: $r7 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("%s : %s", $r4) 
 ; Statement: return $r7 
(check-sat)
; {description/195094363=([org.apache.dubbo.rpc.TriRpcStatus], java.lang.String), arr-var2644-init=([], java.lang.Object[]), code/195094363=([org.apache.dubbo.rpc.TriRpcStatus], org.apache.dubbo.rpc.TriRpcStatus$Code), cast-from-var3876-to-var2644=([org.apache.dubbo.rpc.TriRpcStatus$Code], java.lang.Object), cast-from-String-to-var2644=([java.lang.String], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String)}
; {var164=org.apache.dubbo.rpc.TriRpcStatus, var1724=r0, var2087=$r1, var752=null_type, var2644=java.lang.Object, var1773=$r4, var3876=org.apache.dubbo.rpc.TriRpcStatus$Code, var532=$r5, var3101=$r6, var1307=$r7}
; {org.apache.dubbo.rpc.TriRpcStatus=var164, r0=var1724, $r1=var2087, null_type=var752, java.lang.Object=var2644, $r4=var1773, org.apache.dubbo.rpc.TriRpcStatus$Code=var3876, $r5=var532, $r6=var3101, $r7=var1307}
;seq <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.TriRpcStatus;	$r1 = r0.<org.apache.dubbo.rpc.TriRpcStatus: java.lang.String description>;	if $r1 == null goto $r2 = r0.<org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.TriRpcStatus$Code code>;	$r4 = newarray (java.lang.Object)[2];	$r5 = r0.<org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.TriRpcStatus$Code code>;	$r4[0] = $r5;	$r6 = r0.<org.apache.dubbo.rpc.TriRpcStatus: java.lang.String description>;	$r4[1] = $r6;	$r7 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("%s : %s", $r4);	return $r7
;block_num 2