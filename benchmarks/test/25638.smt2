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

(declare-sort var3585 0)
(declare-sort var753 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun indexOf/-1037706067 ((s String) (c Int)) Int (str.indexof s (str.from_code c) 0))
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun var753-init () var753)
(declare-fun <init>/-1071581066 (var753 String String Bool) void)
(declare-const null-String String)
(declare-const null-NullType var3585)
(declare-const var30 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var30 null-String)))
(assert true)
(define-const var1033 Int (indexOf/-1037706067 var30 61)) ; Statement: i0 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(61) 
(define-const var3504 Int (cast-from-Int-to-Int -1)) ; Statement: $i7 = (int) -1 
 ; Statement: if i0 != $i7 goto (branch) 
(assert (not (not (= var1033 var3504)))) ; Negate: Cond: i0 != $i7  
(assert true)
(define-const var768 Int (indexOf/-1037706067 var30 33)) ; Statement: $i5 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(33) 
 ; Statement: if $i5 != 0 goto $z5 = 0 
(assert (not (not (= var768 0)))) ; Negate: Cond: $i5 != 0  
(define-const var2008 Bool (ite (= 1 1) true false)) ; Statement: $z5 = 1 
(define-const var3041 Bool (ite (= 1 1) true false)) ; Statement: $z4 = 1 
 ; Statement: goto [?= z1 = $z5] 
(assert true) ; Non Conditional
(define-const var3405 Bool var2008) ; Statement: z1 = $z5 
(define-const var2415 var753 var753-init) ; Statement: $r6 = new org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression 
 ; Statement: if $z4 == 0 goto $r4 = r0 
(assert (= (ite var3041 1 0) 0)) ; Cond: $z4 == 0 
(define-const var1116 String var30) ; Statement: $r4 = r0 
(assert true) ; Non Conditional
(assert true)
;(assert (<init>/-1071581066 var2415 var1116 null-String var3405)) ; Statement: specialinvoke $r6.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression: void <init>(java.lang.String,java.lang.String,boolean)>($r4, null, z1) 

(declare-const var2415!1 var753)
(declare-const var1116!1 String)
(declare-const var3547 var3585)
(declare-const var3405!1 Bool)
 ; Statement: return $r6 
(check-sat)
; {indexOf/-1037706067=([java.lang.String, int], int), cast-from-Int-to-Int=([int], int), var753-init=([], org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression), <init>/-1071581066=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression, java.lang.String, java.lang.String, boolean], void)}
; {var30=r0, var3585=null_type, var1033=i0, var3504=$i7, var768=$i5, var2008=$z5, var3041=$z4, var3405=z1, var753=org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression, var2415=$r6, var1116=$r4, var3547=null}
; {r0=var30, null_type=var3585, i0=var1033, $i7=var3504, $i5=var768, $z5=var2008, $z4=var3041, z1=var3405, org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression=var753, $r6=var2415, $r4=var1116, null=var3547}
;seq <java.lang.String: int indexOf(int)>;	<java.lang.String: int indexOf(int)>
;cnt {"<java.lang.String: int indexOf(int)>": 2}
;stmts r0 := @parameter0: java.lang.String;	i0 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(61);	$i7 = (int) -1;	if i0 != $i7 goto (branch);	$i5 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(33);	if $i5 != 0 goto $z5 = 0;	$z5 = 1;	$z4 = 1;	goto [?= z1 = $z5];	z1 = $z5;	$r6 = new org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression;	if $z4 == 0 goto $r4 = r0;	$r4 = r0;	specialinvoke $r6.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression: void <init>(java.lang.String,java.lang.String,boolean)>($r4, null, z1);	return $r6
;block_num 6