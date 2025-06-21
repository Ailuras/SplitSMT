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

(declare-sort var3139 0)
(declare-sort var2447 0)
(declare-sort var741 0)
(declare-sort var3397 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3139-init () var3139)
(declare-fun <init>/-201242697 (var3139) void)
(declare-fun getName/1445248319 (var2447) String)
(declare-fun String_valueOf/1240665136 (Int) String)
(declare-fun var741_put/1464166817 (var741 var3397 var3397) var3397)
(declare-fun cast-from-var3139-to-var741 (var3139) var741)
(declare-fun cast-from-String-to-var3397 (String) var3397)
(declare-const null-Int Int)
(declare-const var2447-STATUS_KEY var2447)
(declare-const var485 Int) ; Statement: i0 := @parameter0: int 
(assert (not (= var485 null-Int)))
(define-const var897 var3139 var3139-init) ; Statement: $r0 = new java.util.HashMap 
(assert true)
;(assert (<init>/-201242697 var897)) ; Statement: specialinvoke $r0.<java.util.HashMap: void <init>()>() 

(declare-const var897!1 var3139)
(define-const var294 var2447 var2447-STATUS_KEY) ; Statement: $r1 = <org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum: org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum STATUS_KEY> 
(assert true)
(define-const var3921 String (getName/1445248319 var294)) ; Statement: $r3 = virtualinvoke $r1.<org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum: java.lang.String getName()>() 
(define-const var860 String (String_valueOf/1240665136 var485)) ; Statement: $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(i0) 
;(assert (var741_put/1464166817 (cast-from-var3139-to-var741 var897!1) (cast-from-String-to-var3397 var3921) (cast-from-String-to-var3397 var860))) ; Statement: interfaceinvoke $r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>($r3, $r2) 

(declare-const var897!2 var3139)
(declare-const var3921!1 String)
(declare-const var860!1 String)
 ; Statement: return $r0 
(check-sat)
; {var3139-init=([], java.util.HashMap), <init>/-201242697=([java.util.HashMap], void), getName/1445248319=([org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum], java.lang.String), String_valueOf/1240665136=([int], java.lang.String), var741_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-var3139-to-var741=([java.util.HashMap], java.util.Map), cast-from-String-to-var3397=([java.lang.String], java.lang.Object)}
; {var485=i0, var3139=java.util.HashMap, var897=$r0, var2447=org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum, var294=$r1, var3921=$r3, var860=$r2, var741=java.util.Map, var3397=java.lang.Object}
; {i0=var485, java.util.HashMap=var3139, $r0=var897, org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum=var2447, $r1=var294, $r3=var3921, $r2=var860, java.util.Map=var741, java.lang.Object=var3397}
;seq <java.lang.String: java.lang.String valueOf(int)>
;cnt {"<java.lang.String: java.lang.String valueOf(int)>": 1}
;stmts i0 := @parameter0: int;	$r0 = new java.util.HashMap;	specialinvoke $r0.<java.util.HashMap: void <init>()>();	$r1 = <org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum: org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum STATUS_KEY>;	$r3 = virtualinvoke $r1.<org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum: java.lang.String getName()>();	$r2 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(i0);	interfaceinvoke $r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>($r3, $r2);	return $r0
;block_num 1