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

(declare-sort var2571 0)
(declare-sort var3490 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun indexOf/-1037706067 ((s String) (c Int)) Int (str.indexof s (str.from_code c) 0))
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun var3490-init () var3490)
(define-fun substring/-1240304868 ((s String) (begin Int) (end Int)) String (str.substr s begin (- end begin)))
(define-fun substring/850833817 ((s String) (begin Int)) String (str.substr s begin (- (str.len s) begin)))
(declare-fun <init>/-1071581066 (var3490 String String Bool) void)
(declare-const null-String String)
(declare-const var864 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var864 null-String)))
(assert true)
(define-const var666 Int (indexOf/-1037706067 var864 61)) ; Statement: i0 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(61) 
(define-const var9 Int (cast-from-Int-to-Int -1)) ; Statement: $i7 = (int) -1 
 ; Statement: if i0 != $i7 goto (branch) 
(assert (not (= var666 var9))) ; Cond: i0 != $i7 
 ; Statement: if i0 <= 0 goto $z7 = 0 
(assert (<= var666 0)) ; Cond: i0 <= 0 
(define-const var1813 Bool (ite (= 1 0) true false)) ; Statement: $z7 = 0 
(define-const var254 Bool (ite (= 1 0) true false)) ; Statement: $z6 = 0 
(assert true) ; Non Conditional
(define-const var145 Bool var254) ; Statement: z3 = $z6 
(define-const var403 var3490 var3490-init) ; Statement: $r7 = new org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression 
 ; Statement: if $z7 == 0 goto $r5 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(0, i0) 
(assert (= (ite var1813 1 0) 0)) ; Cond: $z7 == 0 
(assert (and true (and (>= 0 0) (>= (str.len var864) var666) (>= var666 0))))
(define-const var3181 String (substring/-1240304868 var864 0 var666)) ; Statement: $r5 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(0, i0) 
(assert true) ; Non Conditional
(define-const var114 Int (+ var666 1)) ; Statement: $i1 = i0 + 1 
(assert (and true (and (>= var114 0) (>= (str.len var864) var114))))
(define-const var3224 String (substring/850833817 var864 var114)) ; Statement: $r2 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int)>($i1) 
(assert true)
;(assert (<init>/-1071581066 var403 var3181 var3224 var145)) ; Statement: specialinvoke $r7.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression: void <init>(java.lang.String,java.lang.String,boolean)>($r5, $r2, z3) 

(declare-const var403!1 var3490)
(declare-const var3181!1 String)
(declare-const var3224!1 String)
(declare-const var145!1 Bool)
 ; Statement: return $r7 
(check-sat)
; {indexOf/-1037706067=([java.lang.String, int], int), cast-from-Int-to-Int=([int], int), var3490-init=([], org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression), substring/-1240304868=([java.lang.String, int, int], java.lang.String), substring/850833817=([java.lang.String, int], java.lang.String), <init>/-1071581066=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression, java.lang.String, java.lang.String, boolean], void)}
; {var864=r0, var2571=null_type, var666=i0, var9=$i7, var1813=$z7, var254=$z6, var145=z3, var3490=org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression, var403=$r7, var3181=$r5, var114=$i1, var3224=$r2}
; {r0=var864, null_type=var2571, i0=var666, $i7=var9, $z7=var1813, $z6=var254, z3=var145, org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression=var3490, $r7=var403, $r5=var3181, $i1=var114, $r2=var3224}
;seq <java.lang.String: int indexOf(int)>;	<java.lang.String: java.lang.String substring(int,int)>;	<java.lang.String: java.lang.String substring(int)>
;cnt {"<java.lang.String: int indexOf(int)>": 1,"<java.lang.String: java.lang.String substring(int,int)>": 1,"<java.lang.String: java.lang.String substring(int)>": 1}
;stmts r0 := @parameter0: java.lang.String;	i0 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(61);	$i7 = (int) -1;	if i0 != $i7 goto (branch);	if i0 <= 0 goto $z7 = 0;	$z7 = 0;	$z6 = 0;	z3 = $z6;	$r7 = new org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression;	if $z7 == 0 goto $r5 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(0, i0);	$r5 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(0, i0);	$i1 = i0 + 1;	$r2 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int)>($i1);	specialinvoke $r7.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.NameValueExpression: void <init>(java.lang.String,java.lang.String,boolean)>($r5, $r2, z3);	return $r7
;block_num 6