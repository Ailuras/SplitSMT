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

(declare-sort var225 0)
(declare-sort var3366 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun indexOf/-1037706067 ((s String) (c Int)) Int (str.indexof s (str.from_code c) 0))
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun var3366-init () var3366)
(define-fun substring/850833817 ((s String) (begin Int)) String (str.substr s begin (- (str.len s) begin)))
(declare-fun <init>/-1071581066 (var3366 String String Bool) void)
(declare-const null-String String)
(declare-const null-NullType var225)
(declare-const var2294 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2294 null-String)))
(assert true)
(define-const var3324 Int (indexOf/-1037706067 var2294 61)) ; Statement: i0 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(61) 
(define-const var2273 Int (cast-from-Int-to-Int -1)) ; Statement: $i7 = (int) -1 
 ; Statement: if i0 != $i7 goto (branch) 
(assert (not (not (= var3324 var2273)))) ; Negate: Cond: i0 != $i7  
(assert true)
(define-const var2084 Int (indexOf/-1037706067 var2294 33)) ; Statement: $i5 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(33) 
 ; Statement: if $i5 != 0 goto $z5 = 0 
(assert (not (= var2084 0))) ; Cond: $i5 != 0 
(define-const var571 Bool (ite (= 1 0) true false)) ; Statement: $z5 = 0 
(define-const var589 Bool (ite (= 1 0) true false)) ; Statement: $z4 = 0 
(assert true) ; Non Conditional
(define-const var1231 Bool var571) ; Statement: z1 = $z5 
(define-const var2301 var3366 var3366-init) ; Statement: $r6 = new org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression 
 ; Statement: if $z4 == 0 goto $r4 = r0 
(assert (not (= (ite var589 1 0) 0))) ; Negate: Cond: $z4 == 0  
(assert (not (and true (and (>= 1 0) (>= (str.len var2294) 1)))))
(check-sat)
; {indexOf/-1037706067=([java.lang.String, int], int), cast-from-Int-to-Int=([int], int), var3366-init=([], org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression), substring/850833817=([java.lang.String, int], java.lang.String), <init>/-1071581066=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression, java.lang.String, java.lang.String, boolean], void)}
; {var2294=r0, var225=null_type, var3324=i0, var2273=$i7, var2084=$i5, var571=$z5, var589=$z4, var1231=z1, var3366=org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression, var2301=$r6, var789=$r4, var3910=null}
; {r0=var2294, null_type=var225, i0=var3324, $i7=var2273, $i5=var2084, $z5=var571, $z4=var589, z1=var1231, org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression=var3366, $r6=var2301, $r4=var789, null=var3910}
;seq <java.lang.String: int indexOf(int)>;	<java.lang.String: int indexOf(int)>;	<java.lang.String: java.lang.String substring(int)>
;cnt {"<java.lang.String: int indexOf(int)>": 2,"<java.lang.String: java.lang.String substring(int)>": 1}
;stmts r0 := @parameter0: java.lang.String;	i0 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(61);	$i7 = (int) -1;	if i0 != $i7 goto (branch);	$i5 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(33);	if $i5 != 0 goto $z5 = 0;	$z5 = 0;	$z4 = 0;	z1 = $z5;	$r6 = new org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression;	if $z4 == 0 goto $r4 = r0;	$r4 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int)>(1);	goto [?= specialinvoke $r6.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression: void <init>(java.lang.String,java.lang.String,boolean)>($r4, null, z1)];	specialinvoke $r6.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression: void <init>(java.lang.String,java.lang.String,boolean)>($r4, null, z1);	return $r6
;block_num 6