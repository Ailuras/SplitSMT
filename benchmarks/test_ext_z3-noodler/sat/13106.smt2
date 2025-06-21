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

(declare-sort var128 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun indexLastCol/-943467599 (var128 (Array Int Int)) Int)
(declare-fun getLength-Arr-Int-1 ((Array Int Int)) Int)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var128 var128)
(declare-const null-__Array__Int__Int__ (Array Int Int))
(declare-const var2538 var128) ; Statement: r1 := @this: org.apache.dubbo.qos.textui.TTable 
(assert (not (= var2538 null-var128)))
(declare-const var2143 (Array Int Int)) ; Statement: r2 := @parameter0: int[] 
(assert (not (= var2143 null-__Array__Int__Int__)))
(define-const var824 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var824)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var824!1 String)
(assert (= var824!1 ""))
(assert true)
(define-const var3800 Int (indexLastCol/-943467599 var2538 var2143)) ; Statement: i0 = specialinvoke r1.<org.apache.dubbo.qos.textui.TTable: int indexLastCol(int[])>(r2) 
(define-const var3633 Int (getLength-Arr-Int-1 var2143)) ; Statement: i1 = lengthof r2 
(define-const var3677 Int 0) ; Statement: i3 = 0 
(assert true) ; Non Conditional
 ; Statement: if i3 >= i1 goto $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (>= var3677 var3633)) ; Cond: i3 >= i1 
(assert true)
(define-const var2358 String (toString/-2075883882 var824!1)) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r3 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), indexLastCol/-943467599=([org.apache.dubbo.qos.textui.TTable, int[]], int), getLength-Arr-Int-1=([int[]], int), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var128=org.apache.dubbo.qos.textui.TTable, var2538=r1, var2143=r2, var824=$r0, var3800=i0, var3633=i1, var3677=i3, var2358=$r3}
; {org.apache.dubbo.qos.textui.TTable=var128, r1=var2538, r2=var2143, $r0=var824, i0=var3800, i1=var3633, i3=var3677, $r3=var2358}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.qos.textui.TTable;	r2 := @parameter0: int[];	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	i0 = specialinvoke r1.<org.apache.dubbo.qos.textui.TTable: int indexLastCol(int[])>(r2);	i1 = lengthof r2;	i3 = 0;	if i3 >= i1 goto $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r3
;block_num 3