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

(declare-sort var1763 0)
(declare-sort var148 0)
(declare-sort var3799 0)
(declare-sort var2592 0)
(declare-sort var1597 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun segments/617490631 (var1763) var3799)
(declare-fun var2592-init () var2592)
(declare-fun buf/617490631 (var1763) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1550638998 (var2592 var148 String) void)
(declare-fun var3799_add/328494887 (var3799 var1597) Bool)
(declare-fun cast-from-var2592-to-var1597 (var2592) var1597)
(declare-fun setLength/1276735992 (String Int) void)
(declare-const null-var1763 var1763)
(declare-const null-var148 var148)
(declare-const var1081 var1763) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathParser 
(assert (not (= var1081 null-var1763)))
(declare-const var405 var148) ; Statement: r2 := @parameter0: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment$Type 
(assert (not (= var405 null-var148)))
(define-const var2131 var3799 (segments/617490631 var1081)) ; Statement: $r4 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathParser: java.util.List segments> 
(define-const var3725 var2592 var2592-init) ; Statement: $r1 = new org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment 
(define-const var1627 String (buf/617490631 var1081)) ; Statement: $r3 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathParser: java.lang.StringBuilder buf> 
(assert true)
(define-const var2254 String (toString/-2075883882 var1627)) ; Statement: $r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1550638998 var3725 var405 var2254)) ; Statement: specialinvoke $r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment: void <init>(org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment$Type,java.lang.String)>(r2, $r5) 

(declare-const var3725!1 var2592)
(declare-const var405!1 var148)
(declare-const var2254!1 String)
;(assert (var3799_add/328494887 var2131 (cast-from-var2592-to-var1597 var3725!1))) ; Statement: interfaceinvoke $r4.<java.util.List: boolean add(java.lang.Object)>($r1) 

(declare-const var2131!1 var3799)
(declare-const var3725!2 var2592)
(define-const var1367 String (buf/617490631 var1081)) ; Statement: $r6 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathParser: java.lang.StringBuilder buf> 
(assert true)
;(assert (setLength/1276735992 var1367 0)) ; Statement: virtualinvoke $r6.<java.lang.StringBuilder: void setLength(int)>(0) 

(declare-const var1367!1 String)
(declare-const var3119 Int)
 ; Statement: return 
(check-sat)
; {segments/617490631=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathParser], java.util.List), var2592-init=([], org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment), buf/617490631=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathParser], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1550638998=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment, org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment$Type, java.lang.String], void), var3799_add/328494887=([java.util.List, java.lang.Object], boolean), cast-from-var2592-to-var1597=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment], java.lang.Object), setLength/1276735992=([java.lang.StringBuilder, int], void)}
; {var1763=org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathParser, var1081=r0, var148=org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment$Type, var405=r2, var3799=java.util.List, var2131=$r4, var2592=org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment, var3725=$r1, var1627=$r3, var2254=$r5, var1597=java.lang.Object, var1367=$r6, var3119=0}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathParser=var1763, r0=var1081, org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment$Type=var148, r2=var405, java.util.List=var3799, $r4=var2131, org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment=var2592, $r1=var3725, $r3=var1627, $r5=var2254, java.lang.Object=var1597, $r6=var1367, 0=var3119}
;seq <java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: void setLength(int)>
;cnt {"<java.lang.StringBuilder: java.lang.String toString()>": 1,"<java.lang.StringBuilder: void setLength(int)>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathParser;	r2 := @parameter0: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment$Type;	$r4 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathParser: java.util.List segments>;	$r1 = new org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment;	$r3 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathParser: java.lang.StringBuilder buf>;	$r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment: void <init>(org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment$Type,java.lang.String)>(r2, $r5);	interfaceinvoke $r4.<java.util.List: boolean add(java.lang.Object)>($r1);	$r6 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathParser: java.lang.StringBuilder buf>;	virtualinvoke $r6.<java.lang.StringBuilder: void setLength(int)>(0);	return
;block_num 1