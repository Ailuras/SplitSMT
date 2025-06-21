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

(declare-sort var3604 0)
(declare-sort var1041 0)
(declare-sort var3784 0)
(declare-sort var1976 0)
(declare-sort var3390 0)
(declare-sort var1319 0)
(declare-sort var1062 0)
(declare-sort var1930 0)
(declare-sort var2407 0)
(declare-sort var2527 0)
(declare-sort var68 0)
(declare-sort var2461 0)
(declare-sort var1647 0)
(declare-sort var2374 0)
(declare-sort var3172 0)
(declare-sort var1809 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var1041_lineSeparator/-342590142 () String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun frameworkModel/-1415014413 (var3604) var3784)
(declare-fun getServiceRepository/-1841533664 (var3784) var1976)
(declare-fun allConsumerModels/1613809471 (var1976) var3390)
(declare-fun var1062_stream/-1288525013 (var1062) var1319)
(declare-fun cast-from-var3390-to-var1062 (var3390) var1062)
(declare-fun var2407_bootstrap$/1540039907 () var1930)
(declare-fun var2527_comparing/-789310709 (var1930) var2527)
(declare-fun var1319_sorted/412285068 (var1319 var2527) var1319)
(declare-fun var2461_toList/714215649 () var68)
(declare-fun var1319_collect/-2050842585 (var1319 var68) var1647)
(declare-fun cast-from-var1647-to-var1062 (var1647) var1062)
(declare-fun var2374-init () var2374)
(declare-fun arr-var3172-init () (Array Int var3172))
(declare-fun var3172-init () var3172)
(declare-fun <init>/777921279 (var3172 var1809) void)
(declare-fun <init>/-426181584 (var2374 (Array Int var3172)) void)
(declare-fun arr-var1647-init () (Array Int var1647))
(declare-fun cast-from-String-to-var1647 (String) var1647)
(declare-fun addRow/1508513099 (var2374 (Array Int var1647)) var2374)
(declare-fun var1062_iterator/-1617794947 (var1062) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(declare-fun rendering/1955347074 (var2374) String)
(declare-const null-var3604 var3604)
(declare-const var1809-MIDDLE var1809)
(declare-const null-__Array__Int__var3172__ (Array Int var3172))
(declare-const null-__Array__Int__var1647__ (Array Int var1647))
(declare-const var2665 var3604) ; Statement: r6 := @this: org.apache.dubbo.qos.command.impl.Ls 
(assert (not (= var2665 null-var3604)))
(define-const var2602 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2602)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2602!1 String)
(assert (= var2602!1 ""))
(define-const var3507 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3507)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3507!1 String)
(assert (= var3507!1 ""))
(assert true)
(define-const var1706 String (append/672562846 var3507!1 "As Consumer side:")) ; Statement: $r3 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("As Consumer side:") 
(declare-const var3507!2 String)
(assert (= var3507!2 (str.++ var3507!1 "As Consumer side:")))
(define-const var557 String var1041_lineSeparator/-342590142) ; Statement: $r2 = staticinvoke <java.lang.System: java.lang.String lineSeparator()>() 
(assert true)
(define-const var1242 String (append/672562846 var1706 var557)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var1706!1 String)
(assert (= var1706!1 (str.++ var1706 var557)))
(assert true)
(define-const var1844 String (toString/-2075883882 var1242)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (append/672562846 var2602!1 var1844)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var2602!2 String)
(assert (= var2602!2 (str.++ var2602!1 var1844)))
(define-const var1968 var3784 (frameworkModel/-1415014413 var2665)) ; Statement: $r7 = r6.<org.apache.dubbo.qos.command.impl.Ls: org.apache.dubbo.rpc.model.FrameworkModel frameworkModel> 
(assert true)
(define-const var1645 var1976 (getServiceRepository/-1841533664 var1968)) ; Statement: $r8 = virtualinvoke $r7.<org.apache.dubbo.rpc.model.FrameworkModel: org.apache.dubbo.rpc.model.FrameworkServiceRepository getServiceRepository()>() 
(assert true)
(define-const var1989 var3390 (allConsumerModels/1613809471 var1645)) ; Statement: r30 = virtualinvoke $r8.<org.apache.dubbo.rpc.model.FrameworkServiceRepository: java.util.List allConsumerModels()>() 
(define-const var143 var1319 (var1062_stream/-1288525013 (cast-from-var3390-to-var1062 var1989))) ; Statement: $r11 = interfaceinvoke r30.<java.util.Collection: java.util.stream.Stream stream()>() 
(define-const var1810 var1930 var2407_bootstrap$/1540039907) ; Statement: $r9 = staticinvoke <org.apache.dubbo.qos.command.impl.Ls$getServiceKey__876: java.util.function.Function bootstrap$()>() 
(define-const var2403 var2527 (var2527_comparing/-789310709 var1810)) ; Statement: $r10 = staticinvoke <java.util.Comparator: java.util.Comparator comparing(java.util.function.Function)>($r9) 
(define-const var2088 var1319 (var1319_sorted/412285068 var143 var2403)) ; Statement: $r13 = interfaceinvoke $r11.<java.util.stream.Stream: java.util.stream.Stream sorted(java.util.Comparator)>($r10) 
(define-const var595 var68 var2461_toList/714215649) ; Statement: $r12 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector toList()>() 
(define-const var1280 var1647 (var1319_collect/-2050842585 var2088 var595)) ; Statement: $r14 = interfaceinvoke $r13.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r12) 
(define-const var2675 var1062 (cast-from-var1647-to-var1062 var1280)) ; Statement: r31 = (java.util.Collection) $r14 
(define-const var1436 var2374 var2374-init) ; Statement: $r15 = new org.apache.dubbo.qos.textui.TTable 
(define-const var2460 (Array Int var3172) arr-var3172-init) ; Statement: $r16 = newarray (org.apache.dubbo.qos.textui.TTable$ColumnDefine)[2] 
(define-const var790 var3172 var3172-init) ; Statement: $r17 = new org.apache.dubbo.qos.textui.TTable$ColumnDefine 
(define-const var2117 var1809 var1809-MIDDLE) ; Statement: $r18 = <org.apache.dubbo.qos.textui.TTable$Align: org.apache.dubbo.qos.textui.TTable$Align MIDDLE> 
(assert true)
;(assert (<init>/777921279 var790 var2117)) ; Statement: specialinvoke $r17.<org.apache.dubbo.qos.textui.TTable$ColumnDefine: void <init>(org.apache.dubbo.qos.textui.TTable$Align)>($r18) 

(declare-const var790!1 var3172)
(declare-const var2117!1 var1809)
(declare-const var2460!1 (Array Int var3172))
(assert (not (= var2460!1 null-__Array__Int__var3172__)))
(assert (= (select var2460!1 0) var790!1)) ; Statement: $r16[0] = $r17 
(define-const var3516 var3172 var3172-init) ; Statement: $r19 = new org.apache.dubbo.qos.textui.TTable$ColumnDefine 
(define-const var2871 var1809 var1809-MIDDLE) ; Statement: $r20 = <org.apache.dubbo.qos.textui.TTable$Align: org.apache.dubbo.qos.textui.TTable$Align MIDDLE> 
(assert true)
;(assert (<init>/777921279 var3516 var2871)) ; Statement: specialinvoke $r19.<org.apache.dubbo.qos.textui.TTable$ColumnDefine: void <init>(org.apache.dubbo.qos.textui.TTable$Align)>($r20) 

(declare-const var3516!1 var3172)
(declare-const var2871!1 var1809)
(declare-const var2460!2 (Array Int var3172))
(assert (not (= var2460!2 null-__Array__Int__var3172__)))
(assert (= (select var2460!2 1) var3516!1)) ; Statement: $r16[1] = $r19 
(assert true)
;(assert (<init>/-426181584 var1436 var2460!2)) ; Statement: specialinvoke $r15.<org.apache.dubbo.qos.textui.TTable: void <init>(org.apache.dubbo.qos.textui.TTable$ColumnDefine[])>($r16) 

(declare-const var1436!1 var2374)
(declare-const var2460!3 (Array Int var3172))
(define-const var2787 (Array Int var1647) arr-var1647-init) ; Statement: $r21 = newarray (java.lang.Object)[2] 
(declare-const var2787!1 (Array Int var1647))
(assert (not (= var2787!1 null-__Array__Int__var1647__)))
(assert (= (select var2787!1 0) (cast-from-String-to-var1647 "Consumer Service Name"))) ; Statement: $r21[0] = "Consumer Service Name" 
(declare-const var2787!2 (Array Int var1647))
(assert (not (= var2787!2 null-__Array__Int__var1647__)))
(assert (= (select var2787!2 1) (cast-from-String-to-var1647 "NUM"))) ; Statement: $r21[1] = "NUM" 
(assert true)
;(assert (addRow/1508513099 var1436!1 var2787!2)) ; Statement: virtualinvoke $r15.<org.apache.dubbo.qos.textui.TTable: org.apache.dubbo.qos.textui.TTable addRow(java.lang.Object[])>($r21) 

(declare-const var1436!2 var2374)
(declare-const var2787!3 (Array Int var1647))
(define-const var1126 Iterator (var1062_iterator/-1617794947 var2675)) ; Statement: r22 = interfaceinvoke r31.<java.util.Collection: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var41 Bool (Iterator_hasNext/-1669924200 var1126)) ; Statement: $z0 = interfaceinvoke r22.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z0 == 0 goto $r23 = virtualinvoke $r15.<org.apache.dubbo.qos.textui.TTable: java.lang.String rendering()>() 
(assert (= (ite var41 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var1790 String (rendering/1955347074 var1436!2)) ; Statement: $r23 = virtualinvoke $r15.<org.apache.dubbo.qos.textui.TTable: java.lang.String rendering()>() 
(assert true)
;(assert (append/672562846 var2602!2 var1790)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r23) 
(declare-const var2602!3 String)
(assert (= var2602!3 (str.++ var2602!2 var1790)))
(assert true)
(define-const var308 String (toString/-2075883882 var2602!3)) ; Statement: $r24 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r24 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var1041_lineSeparator/-342590142=([], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), frameworkModel/-1415014413=([org.apache.dubbo.qos.command.impl.Ls], org.apache.dubbo.rpc.model.FrameworkModel), getServiceRepository/-1841533664=([org.apache.dubbo.rpc.model.FrameworkModel], org.apache.dubbo.rpc.model.FrameworkServiceRepository), allConsumerModels/1613809471=([org.apache.dubbo.rpc.model.FrameworkServiceRepository], java.util.List), var1062_stream/-1288525013=([java.util.Collection], java.util.stream.Stream), cast-from-var3390-to-var1062=([java.util.List], java.util.Collection), var2407_bootstrap$/1540039907=([], java.util.function.Function), var2527_comparing/-789310709=([java.util.function.Function], java.util.Comparator), var1319_sorted/412285068=([java.util.stream.Stream, java.util.Comparator], java.util.stream.Stream), var2461_toList/714215649=([], java.util.stream.Collector), var1319_collect/-2050842585=([java.util.stream.Stream, java.util.stream.Collector], java.lang.Object), cast-from-var1647-to-var1062=([java.lang.Object], java.util.Collection), var2374-init=([], org.apache.dubbo.qos.textui.TTable), arr-var3172-init=([], org.apache.dubbo.qos.textui.TTable$ColumnDefine[]), var3172-init=([], org.apache.dubbo.qos.textui.TTable$ColumnDefine), <init>/777921279=([org.apache.dubbo.qos.textui.TTable$ColumnDefine, org.apache.dubbo.qos.textui.TTable$Align], void), <init>/-426181584=([org.apache.dubbo.qos.textui.TTable, org.apache.dubbo.qos.textui.TTable$ColumnDefine[]], void), arr-var1647-init=([], java.lang.Object[]), cast-from-String-to-var1647=([java.lang.String], java.lang.Object), addRow/1508513099=([org.apache.dubbo.qos.textui.TTable, java.lang.Object[]], org.apache.dubbo.qos.textui.TTable), var1062_iterator/-1617794947=([java.util.Collection], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean), rendering/1955347074=([org.apache.dubbo.qos.textui.TTable], java.lang.String)}
; {var3604=org.apache.dubbo.qos.command.impl.Ls, var2665=r6, var2602=$r0, var3507=$r1, var1706=$r3, var1041=java.lang.System, var557=$r2, var1242=$r4, var1844=$r5, var3784=org.apache.dubbo.rpc.model.FrameworkModel, var1968=$r7, var1976=org.apache.dubbo.rpc.model.FrameworkServiceRepository, var1645=$r8, var3390=java.util.List, var1989=r30, var1319=java.util.stream.Stream, var1062=java.util.Collection, var143=$r11, var1930=java.util.function.Function, var2407=org.apache.dubbo.qos.command.impl.Ls$getServiceKey__876, var1810=$r9, var2527=java.util.Comparator, var2403=$r10, var2088=$r13, var68=java.util.stream.Collector, var2461=java.util.stream.Collectors, var595=$r12, var1647=java.lang.Object, var1280=$r14, var2675=r31, var2374=org.apache.dubbo.qos.textui.TTable, var1436=$r15, var3172=org.apache.dubbo.qos.textui.TTable$ColumnDefine, var2460=$r16, var790=$r17, var1809=org.apache.dubbo.qos.textui.TTable$Align, var2117=$r18, var3516=$r19, var2871=$r20, var2787=$r21, var1126=r22, var41=$z0, var1790=$r23, var308=$r24}
; {org.apache.dubbo.qos.command.impl.Ls=var3604, r6=var2665, $r0=var2602, $r1=var3507, $r3=var1706, java.lang.System=var1041, $r2=var557, $r4=var1242, $r5=var1844, org.apache.dubbo.rpc.model.FrameworkModel=var3784, $r7=var1968, org.apache.dubbo.rpc.model.FrameworkServiceRepository=var1976, $r8=var1645, java.util.List=var3390, r30=var1989, java.util.stream.Stream=var1319, java.util.Collection=var1062, $r11=var143, java.util.function.Function=var1930, org.apache.dubbo.qos.command.impl.Ls$getServiceKey__876=var2407, $r9=var1810, java.util.Comparator=var2527, $r10=var2403, $r13=var2088, java.util.stream.Collector=var68, java.util.stream.Collectors=var2461, $r12=var595, java.lang.Object=var1647, $r14=var1280, r31=var2675, org.apache.dubbo.qos.textui.TTable=var2374, $r15=var1436, org.apache.dubbo.qos.textui.TTable$ColumnDefine=var3172, $r16=var2460, $r17=var790, org.apache.dubbo.qos.textui.TTable$Align=var1809, $r18=var2117, $r19=var3516, $r20=var2871, $r21=var2787, r22=var1126, $z0=var41, $r23=var1790, $r24=var308}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.String toString()>": 2}
;stmts r6 := @this: org.apache.dubbo.qos.command.impl.Ls;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("As Consumer side:");	$r2 = staticinvoke <java.lang.System: java.lang.String lineSeparator()>();	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>();	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r7 = r6.<org.apache.dubbo.qos.command.impl.Ls: org.apache.dubbo.rpc.model.FrameworkModel frameworkModel>;	$r8 = virtualinvoke $r7.<org.apache.dubbo.rpc.model.FrameworkModel: org.apache.dubbo.rpc.model.FrameworkServiceRepository getServiceRepository()>();	r30 = virtualinvoke $r8.<org.apache.dubbo.rpc.model.FrameworkServiceRepository: java.util.List allConsumerModels()>();	$r11 = interfaceinvoke r30.<java.util.Collection: java.util.stream.Stream stream()>();	$r9 = staticinvoke <org.apache.dubbo.qos.command.impl.Ls$getServiceKey__876: java.util.function.Function bootstrap$()>();	$r10 = staticinvoke <java.util.Comparator: java.util.Comparator comparing(java.util.function.Function)>($r9);	$r13 = interfaceinvoke $r11.<java.util.stream.Stream: java.util.stream.Stream sorted(java.util.Comparator)>($r10);	$r12 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector toList()>();	$r14 = interfaceinvoke $r13.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r12);	r31 = (java.util.Collection) $r14;	$r15 = new org.apache.dubbo.qos.textui.TTable;	$r16 = newarray (org.apache.dubbo.qos.textui.TTable$ColumnDefine)[2];	$r17 = new org.apache.dubbo.qos.textui.TTable$ColumnDefine;	$r18 = <org.apache.dubbo.qos.textui.TTable$Align: org.apache.dubbo.qos.textui.TTable$Align MIDDLE>;	specialinvoke $r17.<org.apache.dubbo.qos.textui.TTable$ColumnDefine: void <init>(org.apache.dubbo.qos.textui.TTable$Align)>($r18);	$r16[0] = $r17;	$r19 = new org.apache.dubbo.qos.textui.TTable$ColumnDefine;	$r20 = <org.apache.dubbo.qos.textui.TTable$Align: org.apache.dubbo.qos.textui.TTable$Align MIDDLE>;	specialinvoke $r19.<org.apache.dubbo.qos.textui.TTable$ColumnDefine: void <init>(org.apache.dubbo.qos.textui.TTable$Align)>($r20);	$r16[1] = $r19;	specialinvoke $r15.<org.apache.dubbo.qos.textui.TTable: void <init>(org.apache.dubbo.qos.textui.TTable$ColumnDefine[])>($r16);	$r21 = newarray (java.lang.Object)[2];	$r21[0] = "Consumer Service Name";	$r21[1] = "NUM";	virtualinvoke $r15.<org.apache.dubbo.qos.textui.TTable: org.apache.dubbo.qos.textui.TTable addRow(java.lang.Object[])>($r21);	r22 = interfaceinvoke r31.<java.util.Collection: java.util.Iterator iterator()>();	$z0 = interfaceinvoke r22.<java.util.Iterator: boolean hasNext()>();	if $z0 == 0 goto $r23 = virtualinvoke $r15.<org.apache.dubbo.qos.textui.TTable: java.lang.String rendering()>();	$r23 = virtualinvoke $r15.<org.apache.dubbo.qos.textui.TTable: java.lang.String rendering()>();	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r23);	$r24 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r24
;block_num 3