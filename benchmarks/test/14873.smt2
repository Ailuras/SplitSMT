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

(declare-sort var3140 0)
(declare-sort var3610 0)
(declare-sort var3105 0)
(declare-sort var1200 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3140-init () var3140)
(declare-fun <init>/-201242697 (var3140) void)
(declare-fun getName/1445248319 (var3610) String)
(declare-fun String_valueOf/1240665136 (Int) String)
(declare-fun var3105_put/1464166817 (var3105 var1200 var1200) var1200)
(declare-fun cast-from-var3140-to-var3105 (var3140) var3105)
(declare-fun cast-from-String-to-var1200 (String) var1200)
(declare-const null-Int Int)
(declare-const var3610-STATUS_KEY var3610)
(declare-const var838 Int) ; Statement: i0 := @parameter0: int 
(assert (not (= var838 null-Int)))
(define-const var163 var3140 var3140-init) ; Statement: $r0 = new java.util.HashMap 
(assert true)
;(assert (<init>/-201242697 var163)) ; Statement: specialinvoke $r0.<java.util.HashMap: void <init>()>() 

(declare-const var163!1 var3140)
(define-const var2919 var3610 var3610-STATUS_KEY) ; Statement: $r1 = <org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum: org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum STATUS_KEY> 
(assert true)
(define-const var1550 String (getName/1445248319 var2919)) ; Statement: $r3 = virtualinvoke $r1.<org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum: java.lang.String getName()>() 
(define-const var345 String (String_valueOf/1240665136 var838)) ; Statement: $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(i0) 
;(assert (var3105_put/1464166817 (cast-from-var3140-to-var3105 var163!1) (cast-from-String-to-var1200 var1550) (cast-from-String-to-var1200 var345))) ; Statement: interfaceinvoke $r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>($r3, $r2) 

(declare-const var163!2 var3140)
(declare-const var1550!1 String)
(declare-const var345!1 String)
 ; Statement: return $r0 
(check-sat)
; {var3140-init=([], java.util.HashMap), <init>/-201242697=([java.util.HashMap], void), getName/1445248319=([org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum], java.lang.String), String_valueOf/1240665136=([int], java.lang.String), var3105_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-var3140-to-var3105=([java.util.HashMap], java.util.Map), cast-from-String-to-var1200=([java.lang.String], java.lang.Object)}
; {var838=i0, var3140=java.util.HashMap, var163=$r0, var3610=org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum, var2919=$r1, var1550=$r3, var345=$r2, var3105=java.util.Map, var1200=java.lang.Object}
; {i0=var838, java.util.HashMap=var3140, $r0=var163, org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum=var3610, $r1=var2919, $r3=var1550, $r2=var345, java.util.Map=var3105, java.lang.Object=var1200}
;seq <java.lang.String: java.lang.String valueOf(int)>
;cnt {"<java.lang.String: java.lang.String valueOf(int)>": 1}
;stmts i0 := @parameter0: int;	$r0 = new java.util.HashMap;	specialinvoke $r0.<java.util.HashMap: void <init>()>();	$r1 = <org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum: org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum STATUS_KEY>;	$r3 = virtualinvoke $r1.<org.apache.dubbo.rpc.protocol.tri.TripleHeaderEnum: java.lang.String getName()>();	$r2 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(i0);	interfaceinvoke $r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>($r3, $r2);	return $r0
;block_num 1