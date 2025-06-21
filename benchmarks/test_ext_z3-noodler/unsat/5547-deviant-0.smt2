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

(declare-sort var1398 0)
(declare-sort var1736 0)
(declare-sort var1741 0)
(declare-sort var1764 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1736-init () var1736)
(declare-fun <init>/-325640736 (var1736) void)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(define-fun substring/850833817 ((s String) (begin Int)) String (str.substr s begin (- (str.len s) begin)))
(declare-fun var1741_add/328494887 (var1741 var1764) Bool)
(declare-fun cast-from-var1736-to-var1741 (var1736) var1741)
(declare-fun cast-from-String-to-var1764 (String) var1764)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var2261 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2261 null-String)))
(declare-const var118 Int) ; Statement: c1 := @parameter1: char 
(assert (not (= var118 null-Int)))
(define-const var3801 var1736 var1736-init) ; Statement: $r4 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var3801)) ; Statement: specialinvoke $r4.<java.util.ArrayList: void <init>()>() 

(declare-const var3801!1 var1736)
(define-const var3459 Int 0) ; Statement: i3 = 0 
(assert true)
(define-const var1942 Int (length/-134980193 var2261)) ; Statement: i0 = virtualinvoke r1.<java.lang.String: int length()>() 
(define-const var927 Int 0) ; Statement: i4 = 0 
(assert true) ; Non Conditional
 ; Statement: if i4 >= i0 goto (branch) 
(assert (>= var927 var1942)) ; Cond: i4 >= i0 
 ; Statement: if i3 < 0 goto return $r4 
(assert (not (< var3459 0))) ; Negate: Cond: i3 < 0  
(assert (not (and true (and (>= var3459 0) (>= (str.len var2261) var3459)))))
(check-sat)
; {var1736-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void), length/-134980193=([java.lang.String], int), substring/850833817=([java.lang.String, int], java.lang.String), var1741_add/328494887=([java.util.List, java.lang.Object], boolean), cast-from-var1736-to-var1741=([java.util.ArrayList], java.util.List), cast-from-String-to-var1764=([java.lang.String], java.lang.Object)}
; {var2261=r1, var1398=null_type, var118=c1, var1736=java.util.ArrayList, var3801=$r4, var3459=i3, var1942=i0, var927=i4, var1317=$r2, var1741=java.util.List, var1764=java.lang.Object}
; {r1=var2261, null_type=var1398, c1=var118, java.util.ArrayList=var1736, $r4=var3801, i3=var3459, i0=var1942, i4=var927, $r2=var1317, java.util.List=var1741, java.lang.Object=var1764}
;seq <java.lang.String: int length()>;	<java.lang.String: java.lang.String substring(int)>
;cnt {"<java.lang.String: int length()>": 1,"<java.lang.String: java.lang.String substring(int)>": 1}
;stmts r1 := @parameter0: java.lang.String;	c1 := @parameter1: char;	$r4 = new java.util.ArrayList;	specialinvoke $r4.<java.util.ArrayList: void <init>()>();	i3 = 0;	i0 = virtualinvoke r1.<java.lang.String: int length()>();	i4 = 0;	if i4 >= i0 goto (branch);	if i3 < 0 goto return $r4;	$r2 = virtualinvoke r1.<java.lang.String: java.lang.String substring(int)>(i3);	interfaceinvoke $r4.<java.util.List: boolean add(java.lang.Object)>($r2);	return $r4
;block_num 5