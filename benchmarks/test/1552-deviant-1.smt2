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

(declare-sort var1024 0)
(declare-sort var2867 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun charAt/698050440 ((s String) (index Int)) Int (str.to_code (str.at s index)))
(declare-fun var2867_toLowerCase/1461689736 (Int) Int)
(declare-fun append/-1166366385 (String Int) String)
(define-fun substring/850833817 ((s String) (begin Int)) String (str.substr s begin (- (str.len s) begin)))
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-String String)
(declare-const var3377 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3377 null-String)))
(assert true)
(define-const var314 Int (length/-134980193 var3377)) ; Statement: $i0 = virtualinvoke r0.<java.lang.String: int length()>() 
 ; Statement: if $i0 == 1 goto $r1 = new java.lang.StringBuilder 
(assert (= var314 1)) ; Cond: $i0 == 1 
(define-const var3683 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3683)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3683!1 String)
(assert (= var3683!1 ""))
(assert (and true (and (> (str.len var3377) 0) (<= 0 0))))
(define-const var73 Int (charAt/698050440 var3377 0)) ; Statement: $c1 = virtualinvoke r0.<java.lang.String: char charAt(int)>(0) 
(define-const var1388 Int (var2867_toLowerCase/1461689736 var73)) ; Statement: $c2 = staticinvoke <java.lang.Character: char toLowerCase(char)>($c1) 
(assert true)
(define-const var2175 String (append/-1166366385 var3683!1 var1388)) ; Statement: $r3 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>($c2) 
(declare-const var3683!2 String)
(assert (str.prefixof var3683!1 var3683!2))
(assert (not (and true (and (>= 1 0) (>= (str.len var3377) 1)))))
(check-sat)
; {length/-134980193=([java.lang.String], int), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), charAt/698050440=([java.lang.String, int], char), var2867_toLowerCase/1461689736=([char], char), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), substring/850833817=([java.lang.String, int], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3377=r0, var1024=null_type, var314=$i0, var3683=$r1, var73=$c1, var2867=java.lang.Character, var1388=$c2, var2175=$r3, var2628=$r2, var1809=$r4, var3369=$r5}
; {r0=var3377, null_type=var1024, $i0=var314, $r1=var3683, $c1=var73, java.lang.Character=var2867, $c2=var1388, $r3=var2175, $r2=var2628, $r4=var1809, $r5=var3369}
;seq <java.lang.String: int length()>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.String: char charAt(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.String: java.lang.String substring(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: int length()>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.String: char charAt(int)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.String: java.lang.String substring(int)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: java.lang.String;	$i0 = virtualinvoke r0.<java.lang.String: int length()>();	if $i0 == 1 goto $r1 = new java.lang.StringBuilder;	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$c1 = virtualinvoke r0.<java.lang.String: char charAt(int)>(0);	$c2 = staticinvoke <java.lang.Character: char toLowerCase(char)>($c1);	$r3 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>($c2);	$r2 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int)>(1);	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>();	goto [?= return $r5];	return $r5
;block_num 3