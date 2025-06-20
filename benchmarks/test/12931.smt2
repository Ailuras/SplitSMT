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

(declare-sort var1020 0)
(declare-sort var2768 0)
(declare-sort var2993 0)
(declare-sort var2602 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2993-init () var2993)
(declare-fun <init>/1281898776 (var2993) void)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var2768_iterator/-912451715 (var2768) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(declare-fun var1020_put/1464166817 (var1020 var2602 var2602) var2602)
(declare-fun cast-from-String-to-var2602 (String) var2602)
(declare-fun cast-from-var2993-to-var2602 (var2993) var2602)
(declare-const null-String String)
(declare-const null-var1020 var1020)
(declare-const null-var2768 var2768)
(declare-const var3806 String) ; Statement: r1 := @parameter0: java.lang.StringBuilder 
(assert (not (= var3806 null-String)))
(declare-const var2401 var1020) ; Statement: r4 := @parameter1: java.util.Map 
(assert (not (= var2401 null-var1020)))
(declare-const var1843 var2768) ; Statement: r2 := @parameter2: java.util.List 
(assert (not (= var1843 null-var2768)))
(define-const var3666 var2993 var2993-init) ; Statement: $r0 = new java.util.LinkedList 
(assert true)
;(assert (<init>/1281898776 var3666)) ; Statement: specialinvoke $r0.<java.util.LinkedList: void <init>()>() 

(declare-const var3666!1 var2993)
(assert true)
;(assert (append/672562846 var3806 "All Invokers: \n")) ; Statement: virtualinvoke r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("All Invokers: \n") 
(declare-const var3806!1 String)
(assert (= var3806!1 (str.++ var3806 "All Invokers: \n")))
(define-const var3450 Iterator (var2768_iterator/-912451715 var1843)) ; Statement: r3 = interfaceinvoke r2.<java.util.List: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var3382 Bool (Iterator_hasNext/-1669924200 var3450)) ; Statement: $z0 = interfaceinvoke r3.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z0 == 0 goto virtualinvoke r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n") 
(assert (= (ite var3382 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
;(assert (append/672562846 var3806!1 "\n")) ; Statement: virtualinvoke r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n") 
(declare-const var3806!2 String)
(assert (= var3806!2 (str.++ var3806!1 "\n")))
;(assert (var1020_put/1464166817 var2401 (cast-from-String-to-var2602 "All") (cast-from-var2993-to-var2602 var3666!1))) ; Statement: interfaceinvoke r4.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("All", $r0) 

(declare-const var2401!1 var1020)
(declare-const var1521 String)
(declare-const var3666!2 var2993)
 ; Statement: return 
(check-sat)
; {var2993-init=([], java.util.LinkedList), <init>/1281898776=([java.util.LinkedList], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var2768_iterator/-912451715=([java.util.List], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean), var1020_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-String-to-var2602=([java.lang.String], java.lang.Object), cast-from-var2993-to-var2602=([java.util.LinkedList], java.lang.Object)}
; {var3806=r1, var1020=java.util.Map, var2401=r4, var2768=java.util.List, var1843=r2, var2993=java.util.LinkedList, var3666=$r0, var3450=r3, var3382=$z0, var2602=java.lang.Object, var1521="All"}
; {r1=var3806, java.util.Map=var1020, r4=var2401, java.util.List=var2768, r2=var1843, java.util.LinkedList=var2993, $r0=var3666, r3=var3450, $z0=var3382, java.lang.Object=var2602, "All"=var1521}
;seq <java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>
;cnt {"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2}
;stmts r1 := @parameter0: java.lang.StringBuilder;	r4 := @parameter1: java.util.Map;	r2 := @parameter2: java.util.List;	$r0 = new java.util.LinkedList;	specialinvoke $r0.<java.util.LinkedList: void <init>()>();	virtualinvoke r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("All Invokers: \n");	r3 = interfaceinvoke r2.<java.util.List: java.util.Iterator iterator()>();	$z0 = interfaceinvoke r3.<java.util.Iterator: boolean hasNext()>();	if $z0 == 0 goto virtualinvoke r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n");	virtualinvoke r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n");	interfaceinvoke r4.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("All", $r0);	return
;block_num 3