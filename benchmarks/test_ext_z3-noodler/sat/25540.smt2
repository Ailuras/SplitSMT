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

(declare-sort var1757 0)
(declare-sort var1470 0)
(declare-sort var1461 0)
(declare-sort var2074 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-279557996 (var1470) void)
(declare-fun cast-from-var1757-to-var1470 (var1757) var1470)
(declare-fun var1461-init () var1461)
(declare-fun <init>/1281898776 (var1461) void)
(declare-fun cast-from-var1461-to-var2074 (var1461) var2074)
(declare-fun segments/617490631 (var1757) var2074)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun buf/617490631 (var1757) String)
(declare-const null-var1757 var1757)
(declare-const var2070 var1757) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathParser 
(assert (not (= var2070 null-var1757)))
(assert true)
;(assert (<init>/-279557996 (cast-from-var1757-to-var1470 var2070))) ; Statement: specialinvoke r0.<java.lang.Object: void <init>()>() 

(declare-const var2070!1 var1757)
(define-const var2969 var1461 var1461-init) ; Statement: $r1 = new java.util.LinkedList 
(assert true)
;(assert (<init>/1281898776 var2969)) ; Statement: specialinvoke $r1.<java.util.LinkedList: void <init>()>() 

(declare-const var2969!1 var1461)
(declare-const var2070!2 var1757)
(assert (not (= var2070!2 null-var1757)))
(assert (= (segments/617490631 var2070!2) (cast-from-var1461-to-var2074 var2969!1))) ; Statement: r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathParser: java.util.List segments> = $r1 
(define-const var343 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var343)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var343!1 String)
(assert (= var343!1 ""))
(declare-const var2070!3 var1757)
(assert (not (= var2070!3 null-var1757)))
(assert (= (buf/617490631 var2070!3) var343!1)) ; Statement: r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathParser: java.lang.StringBuilder buf> = $r2 
 ; Statement: return 
(check-sat)
; {<init>/-279557996=([java.lang.Object], void), cast-from-var1757-to-var1470=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathParser], java.lang.Object), var1461-init=([], java.util.LinkedList), <init>/1281898776=([java.util.LinkedList], void), cast-from-var1461-to-var2074=([java.util.LinkedList], java.util.List), segments/617490631=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathParser], java.util.List), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), buf/617490631=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathParser], java.lang.StringBuilder)}
; {var1757=org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathParser, var2070=r0, var1470=java.lang.Object, var1461=java.util.LinkedList, var2969=$r1, var2074=java.util.List, var343=$r2}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathParser=var1757, r0=var2070, java.lang.Object=var1470, java.util.LinkedList=var1461, $r1=var2969, java.util.List=var2074, $r2=var343}
;seq <java.lang.StringBuilder: void <init>()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathParser;	specialinvoke r0.<java.lang.Object: void <init>()>();	$r1 = new java.util.LinkedList;	specialinvoke $r1.<java.util.LinkedList: void <init>()>();	r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathParser: java.util.List segments> = $r1;	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathParser: java.lang.StringBuilder buf> = $r2;	return
;block_num 1