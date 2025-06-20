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

(declare-sort var3857 0)
(declare-sort var1887 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun indexOf/-1037706067 ((s String) (c Int)) Int (str.indexof s (str.from_code c) 0))
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun var1887-init () var1887)
(define-fun substring/850833817 ((s String) (begin Int)) String (str.substr s begin (- (str.len s) begin)))
(declare-fun <init>/-1071581066 (var1887 String String Bool) void)
(declare-const null-String String)
(declare-const null-NullType var3857)
(declare-const var640 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var640 null-String)))
(assert true)
(define-const var1653 Int (indexOf/-1037706067 var640 61)) ; Statement: i0 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(61) 
(define-const var676 Int (cast-from-Int-to-Int -1)) ; Statement: $i7 = (int) -1 
 ; Statement: if i0 != $i7 goto (branch) 
(assert (not (not (= var1653 var676)))) ; Negate: Cond: i0 != $i7  
(assert true)
(define-const var3383 Int (indexOf/-1037706067 var640 33)) ; Statement: $i5 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(33) 
 ; Statement: if $i5 != 0 goto $z5 = 0 
(assert (not (not (= var3383 0)))) ; Negate: Cond: $i5 != 0  
(define-const var1192 Bool (ite (= 1 1) true false)) ; Statement: $z5 = 1 
(define-const var2094 Bool (ite (= 1 1) true false)) ; Statement: $z4 = 1 
 ; Statement: goto [?= z1 = $z5] 
(assert true) ; Non Conditional
(define-const var194 Bool var1192) ; Statement: z1 = $z5 
(define-const var3001 var1887 var1887-init) ; Statement: $r6 = new org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression 
 ; Statement: if $z4 == 0 goto $r4 = r0 
(assert (not (= (ite var2094 1 0) 0))) ; Negate: Cond: $z4 == 0  
(assert (and true (and (>= 1 0) (>= (str.len var640) 1))))
(define-const var439 String (substring/850833817 var640 1)) ; Statement: $r4 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int)>(1) 
 ; Statement: goto [?= specialinvoke $r6.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression: void <init>(java.lang.String,java.lang.String,boolean)>($r4, null, z1)] 
(assert true) ; Non Conditional
(assert true)
;(assert (<init>/-1071581066 var3001 var439 null-String var194)) ; Statement: specialinvoke $r6.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression: void <init>(java.lang.String,java.lang.String,boolean)>($r4, null, z1) 

(declare-const var3001!1 var1887)
(declare-const var439!1 String)
(declare-const var2024 var3857)
(declare-const var194!1 Bool)
 ; Statement: return $r6 
(check-sat)
; {indexOf/-1037706067=([java.lang.String, int], int), cast-from-Int-to-Int=([int], int), var1887-init=([], org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression), substring/850833817=([java.lang.String, int], java.lang.String), <init>/-1071581066=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression, java.lang.String, java.lang.String, boolean], void)}
; {var640=r0, var3857=null_type, var1653=i0, var676=$i7, var3383=$i5, var1192=$z5, var2094=$z4, var194=z1, var1887=org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression, var3001=$r6, var439=$r4, var2024=null}
; {r0=var640, null_type=var3857, i0=var1653, $i7=var676, $i5=var3383, $z5=var1192, $z4=var2094, z1=var194, org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression=var1887, $r6=var3001, $r4=var439, null=var2024}
;seq <java.lang.String: int indexOf(int)>;	<java.lang.String: int indexOf(int)>;	<java.lang.String: java.lang.String substring(int)>
;cnt {"<java.lang.String: int indexOf(int)>": 2,"<java.lang.String: java.lang.String substring(int)>": 1}
;stmts r0 := @parameter0: java.lang.String;	i0 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(61);	$i7 = (int) -1;	if i0 != $i7 goto (branch);	$i5 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(33);	if $i5 != 0 goto $z5 = 0;	$z5 = 1;	$z4 = 1;	goto [?= z1 = $z5];	z1 = $z5;	$r6 = new org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression;	if $z4 == 0 goto $r4 = r0;	$r4 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int)>(1);	goto [?= specialinvoke $r6.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression: void <init>(java.lang.String,java.lang.String,boolean)>($r4, null, z1)];	specialinvoke $r6.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression: void <init>(java.lang.String,java.lang.String,boolean)>($r4, null, z1);	return $r6
;block_num 6