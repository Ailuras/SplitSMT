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

(declare-sort var3897 0)
(declare-sort var224 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun indexOf/-1037706067 ((s String) (c Int)) Int (str.indexof s (str.from_code c) 0))
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun var224-init () var224)
(define-fun substring/-1240304868 ((s String) (begin Int) (end Int)) String (str.substr s begin (- end begin)))
(define-fun substring/850833817 ((s String) (begin Int)) String (str.substr s begin (- (str.len s) begin)))
(declare-fun <init>/-1071581066 (var224 String String Bool) void)
(declare-const null-String String)
(declare-const var3843 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3843 null-String)))
(assert true)
(define-const var2234 Int (indexOf/-1037706067 var3843 61)) ; Statement: i0 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(61) 
(define-const var2704 Int (cast-from-Int-to-Int -1)) ; Statement: $i7 = (int) -1 
 ; Statement: if i0 != $i7 goto (branch) 
(assert (not (= var2234 var2704))) ; Cond: i0 != $i7 
 ; Statement: if i0 <= 0 goto $z7 = 0 
(assert (<= var2234 0)) ; Cond: i0 <= 0 
(define-const var1827 Bool (ite (= 1 0) true false)) ; Statement: $z7 = 0 
(define-const var747 Bool (ite (= 1 0) true false)) ; Statement: $z6 = 0 
(assert true) ; Non Conditional
(define-const var1147 Bool var747) ; Statement: z3 = $z6 
(define-const var2884 var224 var224-init) ; Statement: $r7 = new org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression 
 ; Statement: if $z7 == 0 goto $r5 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(0, i0) 
(assert (not (= (ite var1827 1 0) 0))) ; Negate: Cond: $z7 == 0  
(define-const var2983 Int (- var2234 1)) ; Statement: $i2 = i0 - 1 
(assert (and true (and (>= 0 0) (>= (str.len var3843) var2983) (>= var2983 0))))
(define-const var3700 String (substring/-1240304868 var3843 0 var2983)) ; Statement: $r5 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(0, $i2) 
 ; Statement: goto [?= $i1 = i0 + 1] 
(assert true) ; Non Conditional
(define-const var595 Int (+ var2234 1)) ; Statement: $i1 = i0 + 1 
(assert (and true (and (>= var595 0) (>= (str.len var3843) var595))))
(define-const var3145 String (substring/850833817 var3843 var595)) ; Statement: $r2 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int)>($i1) 
(assert true)
;(assert (<init>/-1071581066 var2884 var3700 var3145 var1147)) ; Statement: specialinvoke $r7.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression: void <init>(java.lang.String,java.lang.String,boolean)>($r5, $r2, z3) 

(declare-const var2884!1 var224)
(declare-const var3700!1 String)
(declare-const var3145!1 String)
(declare-const var1147!1 Bool)
 ; Statement: return $r7 
(check-sat)
; {indexOf/-1037706067=([java.lang.String, int], int), cast-from-Int-to-Int=([int], int), var224-init=([], org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression), substring/-1240304868=([java.lang.String, int, int], java.lang.String), substring/850833817=([java.lang.String, int], java.lang.String), <init>/-1071581066=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression, java.lang.String, java.lang.String, boolean], void)}
; {var3843=r0, var3897=null_type, var2234=i0, var2704=$i7, var1827=$z7, var747=$z6, var1147=z3, var224=org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression, var2884=$r7, var2983=$i2, var3700=$r5, var595=$i1, var3145=$r2}
; {r0=var3843, null_type=var3897, i0=var2234, $i7=var2704, $z7=var1827, $z6=var747, z3=var1147, org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression=var224, $r7=var2884, $i2=var2983, $r5=var3700, $i1=var595, $r2=var3145}
;seq <java.lang.String: int indexOf(int)>;	<java.lang.String: java.lang.String substring(int,int)>;	<java.lang.String: java.lang.String substring(int)>
;cnt {"<java.lang.String: int indexOf(int)>": 1,"<java.lang.String: java.lang.String substring(int,int)>": 1,"<java.lang.String: java.lang.String substring(int)>": 1}
;stmts r0 := @parameter0: java.lang.String;	i0 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(61);	$i7 = (int) -1;	if i0 != $i7 goto (branch);	if i0 <= 0 goto $z7 = 0;	$z7 = 0;	$z6 = 0;	z3 = $z6;	$r7 = new org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression;	if $z7 == 0 goto $r5 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(0, i0);	$i2 = i0 - 1;	$r5 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(0, $i2);	goto [?= $i1 = i0 + 1];	$i1 = i0 + 1;	$r2 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int)>($i1);	specialinvoke $r7.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression: void <init>(java.lang.String,java.lang.String,boolean)>($r5, $r2, z3);	return $r7
;block_num 6