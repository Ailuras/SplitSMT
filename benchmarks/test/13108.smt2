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

(declare-sort var200 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun indexLastCol/-943467599 (var200 (Array Int Int)) Int)
(declare-fun getLength-Arr-Int-1 ((Array Int Int)) Int)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var200 var200)
(declare-const null-__Array__Int__Int__ (Array Int Int))
(declare-const var3696 var200) ; Statement: r1 := @this: org.apache.dubbo.qos.textui.TTable 
(assert (not (= var3696 null-var200)))
(declare-const var2624 (Array Int Int)) ; Statement: r2 := @parameter0: int[] 
(assert (not (= var2624 null-__Array__Int__Int__)))
(define-const var3727 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3727)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3727!1 String)
(assert (= var3727!1 ""))
(assert true)
(define-const var1430 Int (indexLastCol/-943467599 var3696 var2624)) ; Statement: i0 = specialinvoke r1.<org.apache.dubbo.qos.textui.TTable: int indexLastCol(int[])>(r2) 
(define-const var2381 Int (getLength-Arr-Int-1 var2624)) ; Statement: i1 = lengthof r2 
(define-const var312 Int 0) ; Statement: i3 = 0 
(assert true) ; Non Conditional
 ; Statement: if i3 >= i1 goto $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (not (>= var312 var2381))) ; Negate: Cond: i3 >= i1  
(define-const var1268 Int (select var2624 var312)) ; Statement: i2 = r2[i3] 
 ; Statement: if i2 > 0 goto (branch) 
(assert (not (> var1268 0))) ; Negate: Cond: i2 > 0  
 ; Statement: goto [?= i3 = i3 + 1] 
(assert true) ; Non Conditional
(define-const var312!1 Int (+ var312 1)) ; Statement: i3 = i3 + 1 
 ; Statement: goto [?= (branch)] 
(assert true) ; Non Conditional
 ; Statement: if i3 >= i1 goto $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (not (>= var312!1 var2381))) ; Negate: Cond: i3 >= i1  
(define-const var1268!1 Int (select var2624 var312!1)) ; Statement: i2 = r2[i3] 
 ; Statement: if i2 > 0 goto (branch) 
(assert (not (> var1268!1 0))) ; Negate: Cond: i2 > 0  
 ; Statement: goto [?= i3 = i3 + 1] 
(assert true) ; Non Conditional
(define-const var312!2 Int (+ var312!1 1)) ; Statement: i3 = i3 + 1 
 ; Statement: goto [?= (branch)] 
(assert true) ; Non Conditional
 ; Statement: if i3 >= i1 goto $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (>= var312!2 var2381)) ; Cond: i3 >= i1 
(assert true)
(define-const var3802 String (toString/-2075883882 var3727!1)) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r3 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), indexLastCol/-943467599=([org.apache.dubbo.qos.textui.TTable, int[]], int), getLength-Arr-Int-1=([int[]], int), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var200=org.apache.dubbo.qos.textui.TTable, var3696=r1, var2624=r2, var3727=$r0, var1430=i0, var2381=i1, var312=i3, var1268=i2, var3802=$r3}
; {org.apache.dubbo.qos.textui.TTable=var200, r1=var3696, r2=var2624, $r0=var3727, i0=var1430, i1=var2381, i3=var312, i2=var1268, $r3=var3802}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.qos.textui.TTable;	r2 := @parameter0: int[];	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	i0 = specialinvoke r1.<org.apache.dubbo.qos.textui.TTable: int indexLastCol(int[])>(r2);	i1 = lengthof r2;	i3 = 0;	if i3 >= i1 goto $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	i2 = r2[i3];	if i2 > 0 goto (branch);	goto [?= i3 = i3 + 1];	i3 = i3 + 1;	goto [?= (branch)];	if i3 >= i1 goto $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	i2 = r2[i3];	if i2 > 0 goto (branch);	goto [?= i3 = i3 + 1];	i3 = i3 + 1;	goto [?= (branch)];	if i3 >= i1 goto $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r3
;block_num 11