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

(declare-sort var2088 0)
(declare-sort var3406 0)
(declare-sort var311 0)
(declare-sort var636 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun root/1508590244 (var2088) var3406)
(declare-fun var311-init () var311)
(declare-fun <init>/175908286 (var311 var2088 String) void)
(declare-fun recursive/593540850 (var2088 Int Bool String var3406 var636) void)
(declare-fun cast-from-var311-to-var636 (var311) var636)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2088 var2088)
(declare-const var3702 var2088) ; Statement: r1 := @this: org.apache.dubbo.qos.textui.TTree 
(assert (not (= var3702 null-var2088)))
(define-const var2514 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2514)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2514!1 String)
(assert (= var2514!1 ""))
(define-const var693 var3406 (root/1508590244 var3702)) ; Statement: $r3 = r1.<org.apache.dubbo.qos.textui.TTree: org.apache.dubbo.qos.textui.TTree$Node root> 
(define-const var815 var311 var311-init) ; Statement: $r2 = new org.apache.dubbo.qos.textui.TTree$1 
(assert true)
;(assert (<init>/175908286 var815 var3702 var2514!1)) ; Statement: specialinvoke $r2.<org.apache.dubbo.qos.textui.TTree$1: void <init>(org.apache.dubbo.qos.textui.TTree,java.lang.StringBuilder)>(r1, $r0) 

(declare-const var815!1 var311)
(declare-const var3702!1 var2088)
(declare-const var2514!2 String)
(assert true)
;(assert (recursive/593540850 var3702!1 0 (ite (= 1 1) true false) "" var693 (cast-from-var311-to-var636 var815!1))) ; Statement: specialinvoke r1.<org.apache.dubbo.qos.textui.TTree: void recursive(int,boolean,java.lang.String,org.apache.dubbo.qos.textui.TTree$Node,org.apache.dubbo.qos.textui.TTree$Callback)>(0, 1, "", $r3, $r2) 

(declare-const var3702!2 var2088)
(declare-const var2153 Int)
(declare-const var2168 Int)
(declare-const var3349 String)
(declare-const var693!1 var3406)
(declare-const var815!2 var311)
(assert true)
(define-const var2924 String (toString/-2075883882 var2514!2)) ; Statement: $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r4 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), root/1508590244=([org.apache.dubbo.qos.textui.TTree], org.apache.dubbo.qos.textui.TTree$Node), var311-init=([], org.apache.dubbo.qos.textui.TTree$1), <init>/175908286=([org.apache.dubbo.qos.textui.TTree$1, org.apache.dubbo.qos.textui.TTree, java.lang.StringBuilder], void), recursive/593540850=([org.apache.dubbo.qos.textui.TTree, int, boolean, java.lang.String, org.apache.dubbo.qos.textui.TTree$Node, org.apache.dubbo.qos.textui.TTree$Callback], void), cast-from-var311-to-var636=([org.apache.dubbo.qos.textui.TTree$1], org.apache.dubbo.qos.textui.TTree$Callback), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2088=org.apache.dubbo.qos.textui.TTree, var3702=r1, var2514=$r0, var3406=org.apache.dubbo.qos.textui.TTree$Node, var693=$r3, var311=org.apache.dubbo.qos.textui.TTree$1, var815=$r2, var636=org.apache.dubbo.qos.textui.TTree$Callback, var2153=0, var2168=1, var3349="", var2924=$r4}
; {org.apache.dubbo.qos.textui.TTree=var2088, r1=var3702, $r0=var2514, org.apache.dubbo.qos.textui.TTree$Node=var3406, $r3=var693, org.apache.dubbo.qos.textui.TTree$1=var311, $r2=var815, org.apache.dubbo.qos.textui.TTree$Callback=var636, 0=var2153, 1=var2168, ""=var3349, $r4=var2924}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.qos.textui.TTree;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = r1.<org.apache.dubbo.qos.textui.TTree: org.apache.dubbo.qos.textui.TTree$Node root>;	$r2 = new org.apache.dubbo.qos.textui.TTree$1;	specialinvoke $r2.<org.apache.dubbo.qos.textui.TTree$1: void <init>(org.apache.dubbo.qos.textui.TTree,java.lang.StringBuilder)>(r1, $r0);	specialinvoke r1.<org.apache.dubbo.qos.textui.TTree: void recursive(int,boolean,java.lang.String,org.apache.dubbo.qos.textui.TTree$Node,org.apache.dubbo.qos.textui.TTree$Callback)>(0, 1, "", $r3, $r2);	$r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r4
;block_num 1