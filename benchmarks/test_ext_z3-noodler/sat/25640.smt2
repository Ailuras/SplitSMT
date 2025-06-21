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

(declare-sort var896 0)
(declare-sort var2125 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun indexOf/-1037706067 ((s String) (c Int)) Int (str.indexof s (str.from_code c) 0))
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun var2125-init () var2125)
(declare-fun <init>/-1071581066 (var2125 String String Bool) void)
(declare-const null-String String)
(declare-const null-NullType var896)
(declare-const var1640 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1640 null-String)))
(assert true)
(define-const var1600 Int (indexOf/-1037706067 var1640 61)) ; Statement: i0 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(61) 
(define-const var508 Int (cast-from-Int-to-Int -1)) ; Statement: $i7 = (int) -1 
 ; Statement: if i0 != $i7 goto (branch) 
(assert (not (not (= var1600 var508)))) ; Negate: Cond: i0 != $i7  
(assert true)
(define-const var1530 Int (indexOf/-1037706067 var1640 33)) ; Statement: $i5 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(33) 
 ; Statement: if $i5 != 0 goto $z5 = 0 
(assert (not (= var1530 0))) ; Cond: $i5 != 0 
(define-const var887 Bool (ite (= 1 0) true false)) ; Statement: $z5 = 0 
(define-const var3282 Bool (ite (= 1 0) true false)) ; Statement: $z4 = 0 
(assert true) ; Non Conditional
(define-const var978 Bool var887) ; Statement: z1 = $z5 
(define-const var2652 var2125 var2125-init) ; Statement: $r6 = new org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression 
 ; Statement: if $z4 == 0 goto $r4 = r0 
(assert (= (ite var3282 1 0) 0)) ; Cond: $z4 == 0 
(define-const var3827 String var1640) ; Statement: $r4 = r0 
(assert true) ; Non Conditional
(assert true)
;(assert (<init>/-1071581066 var2652 var3827 null-String var978)) ; Statement: specialinvoke $r6.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression: void <init>(java.lang.String,java.lang.String,boolean)>($r4, null, z1) 

(declare-const var2652!1 var2125)
(declare-const var3827!1 String)
(declare-const var440 var896)
(declare-const var978!1 Bool)
 ; Statement: return $r6 
(check-sat)
; {indexOf/-1037706067=([java.lang.String, int], int), cast-from-Int-to-Int=([int], int), var2125-init=([], org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression), <init>/-1071581066=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression, java.lang.String, java.lang.String, boolean], void)}
; {var1640=r0, var896=null_type, var1600=i0, var508=$i7, var1530=$i5, var887=$z5, var3282=$z4, var978=z1, var2125=org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression, var2652=$r6, var3827=$r4, var440=null}
; {r0=var1640, null_type=var896, i0=var1600, $i7=var508, $i5=var1530, $z5=var887, $z4=var3282, z1=var978, org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression=var2125, $r6=var2652, $r4=var3827, null=var440}
;seq <java.lang.String: int indexOf(int)>;	<java.lang.String: int indexOf(int)>
;cnt {"<java.lang.String: int indexOf(int)>": 2}
;stmts r0 := @parameter0: java.lang.String;	i0 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(61);	$i7 = (int) -1;	if i0 != $i7 goto (branch);	$i5 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(33);	if $i5 != 0 goto $z5 = 0;	$z5 = 0;	$z4 = 0;	z1 = $z5;	$r6 = new org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression;	if $z4 == 0 goto $r4 = r0;	$r4 = r0;	specialinvoke $r6.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression: void <init>(java.lang.String,java.lang.String,boolean)>($r4, null, z1);	return $r6
;block_num 6